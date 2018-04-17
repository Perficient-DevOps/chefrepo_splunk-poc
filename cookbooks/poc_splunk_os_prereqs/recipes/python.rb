#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: python
#
# Copyright:: 2018, The Authors, All Rights Reserved.

when node['platform']
  case /redhat/
    package 'python2-pip'
  case /centos/
    package %( python python-pip)
end

package %w(python-devel) do
  action :install
end

# using the poise-python library to add a pip resource
python_package 'pyopenssl'
