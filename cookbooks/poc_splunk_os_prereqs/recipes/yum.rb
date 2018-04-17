#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: yum
#
# Copyright:: 2018, The Authors, All Rights Reserved.
##################################
# Splunk install script segments for Linux installs @Allscripts
# This install will REMOVE any old version of splunk and DELETE default Splunk directories
# Only use if you want a new install of Splunk on a new box
#
###################################
# Install packages required by Allscripts for all Splunk boxes
# BE ROOT!
#
#echo "Installing EPEL repositories and updating system."
#yum -y install epel-release
#yum repolist
#yum upgrade -y

#echo "Installing dependencies for later applications"
#yum -y install wget python python-pip python-devel openssl-devel gcc gcc-c++ net-tools tcpdump whois

# TODO: only works in CentOS

when node['platform']
  case /redhat/

    execute 'Refresh Repositories' do
      action :nothing
      command 'yum repolist'
    end
    
    # https://aws.amazon.com/premiumsupport/knowledge-center/ec2-enable-epel/
    execute 'Add EPEL to RHEL 7' do
      command 'yum install –y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm -y'
      notifies :run, 'execute[Refresh Repositories]'
      not_if 'yum repolist|grep epel'
    end

  case /centos/
    yum_package 'epel-release' do
      action :install
      # FIXME: this package is not available in public RHEL repo?
      ignore_failure true
    end
end


# FIXME: Not idempotent so will not have predictable results to test for
# consider something more like https://github.com/bflad/chef-auto-patch/
execute 'perform upgrade of packages' do
  command 'yum upgrade -y'
end

package %w(wget openssl-devel gcc gcc-c++ net-tools tcpdump whois)  do
  action :install
end
