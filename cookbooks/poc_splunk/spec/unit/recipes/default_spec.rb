#
# Cookbook:: poc_splunk
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

equire 'spec_helper'

describe 'poc_splunk::default' do

  let(:secrets) do
    {
      'splunk__default' => {
        'id' => 'splunk__default',
        'auth' => 'admin:notarealpassword',
        'secret' => 'notarealsecret',
      },
    }
  end

  let(:chef_run_init) do
    ChefSpec::ServerRunner.new(platform: platform, version: platform_version) do |node, server|
      node.override['dev_mode'] = true
      node.override['splunk']['is_server'] = true
      # Populate mock vault data bag to the server
      server.create_data_bag('vault', secrets)
    end
  end

  let(:chef_run) do
    chef_run_init.converge(described_recipe)
  end

  before(:each) do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe).and_return(true)
    stub_command("/opt/splunk/bin/splunk enable listen 9997 -auth '#{secrets['splunk__default']['auth']}'").and_return(true)
    # Stub TCP Socket to immediately fail connection to 9997 and raise error without waiting for entire default timeout
    allow(TCPSocket).to receive(:new).with(anything, '9997') { raise Errno::ETIMEDOUT }
  end

  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:platform) { 'Ubuntu' }
    let(:platform_version) { '16.04' }

    before(:each) do
      stub_command("/opt/splunk/bin/splunk show splunkd-port -auth '#{secrets['splunk__default']['auth']}' | grep ': 8089'").and_return('Splunkd port: 8089')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on CentOS 7.4.1708' do
    let(:platform) { 'CentOS' }
    let(:platform_version) { '7.4.1708' }

    before(:each) do
      stub_command("/opt/splunk/bin/splunk show splunkd-port -auth '#{secrets['splunk__default']['auth']}' | grep ': 8089'").and_return('Splunkd port: 8089')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
