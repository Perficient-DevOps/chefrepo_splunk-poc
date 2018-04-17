#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: python
#
# Copyright:: 2018, The Authors, All Rights Reserved.

case node['platform']
  when /redhat/
    package 'python2-pip'
  when /centos/
    package %w(python python-pip)
end

package %w(python-devel) do
  action :install
end

# using the poise-python library to add a pip resource
python_package 'pyopenssl'
