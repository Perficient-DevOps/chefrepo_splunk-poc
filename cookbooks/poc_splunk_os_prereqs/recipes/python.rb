#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: python
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package %w(python python-pip python-devel)  do
  action :install
end

# using the poise-python library to add a pip resource
python_package 'pyopenssl'
