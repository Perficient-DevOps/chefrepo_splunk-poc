#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: disable_selinux
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# See example at https://github.com/chef-cookbooks/selinux/blob/master/resources/state.rb

execute "disable selinux" do
  command "setenforce 0"
  not_if "getenforce | egrep -qx 'Disabled|Permissive'"
end
