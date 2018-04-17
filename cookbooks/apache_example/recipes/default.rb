#
# Cookbook:: apache_example
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


package 'httpd' do
  :install
end

service 'httpd' do
  action [ :enable, :start ]
  retries 3
end
