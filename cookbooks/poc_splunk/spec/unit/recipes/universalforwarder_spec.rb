#
# Cookbook:: poc_splunk
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'poc_splunk::universalforwarder' do
  let(:secrets) do
    {
      'splunk__default' => {
        'id' => 'splunk__default',
        'auth' => 'admin:notarealpassword',
        'secret' => 'notarealsecret',
      },
    }
  end

  let(:splunk_indexer1) do
    stub_node('idx1', platform: platform, version: platform_version) do |node|
      node.automatic['fqdn'] = 'idx1.example.com'
      node.automatic['ipaddress'] = '10.10.15.43'
      node.override['dev_mode'] = true
      node.override['splunk']['is_server'] = true
      node.override['splunk']['receiver_port'] = '1648'
    end
  end

  let(:chef_run_init) do
    ChefSpec::ServerRunner.new(platform: platform, version: platform_version) do |node, server|
      node.override['dev_mode'] = true
      node.override['splunk']['is_server'] = false
      # Populate mock vault data bag to the server
      server.create_data_bag('vault', secrets)
      server.create_node(splunk_indexer1)
    end
  end

  before(:each) do
    # allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_return(true)
    stub_command("/opt/splunk/bin/splunk enable listen 9997 -auth '#{secrets['splunk__default']['auth']}'").and_return(true)
    # Stub TCP Socket to immediately fail connection to 9997 and raise error without waiting for entire default timeout
    allow(TCPSocket).to receive(:new).with(anything, '9997') { raise Errno::ETIMEDOUT }
  end

  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:platform) { 'Ubuntu' }
    let(:platform_version) { '16.04' }

    let(:chef_run) do
      chef_run_init.converge(described_recipe)
    end

    it 'creates the local system directory' do # ~FC005
      expect(chef_run).to create_directory('/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local').with(
        'owner' => 'splunk',
        'group' => 'splunk'
      )
    end

    it 'creates an outputs template in the local system directory' do
      expect(chef_run).to create_template('/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local/inputs.conf')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'converges successfully' do
      stub_command("/opt/splunk/bin/splunk enable listen 9997 -auth '#{secrets['splunk__default']['auth']}'").and_return(false)
      expect { chef_run }.to_not raise_error
    end
  end

  # context 'When all attributes are default, on CentOS 7.4.1708' do
  #   let(:platform) { 'CentOS'}
  #   let(:platform_version) { '7.4.1708' }
  #
  #   it 'converges successfully' do
  #     expect { chef_run }.to_not raise_error
  #   end
  # end
end
