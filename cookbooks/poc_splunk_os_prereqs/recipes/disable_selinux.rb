#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: disable_selinux
#
# Copyright:: 2018, The Authors, All Rights Reserved.
execute "disable selinux - running" do
      command "/usr/sbin/setenforce 0"
end
