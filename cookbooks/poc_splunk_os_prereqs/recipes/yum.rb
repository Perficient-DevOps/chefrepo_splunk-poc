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
#pip install pyopenssl
yum_package 'epel-release' do
  action :install
end

package %w(wget python python-pip python-devel openssl-devel gcc gcc-c++ net-tools tcpdump whois)  do
  action :install
end

execute "pip install" do
      command "pip install pyopenssl"
end
