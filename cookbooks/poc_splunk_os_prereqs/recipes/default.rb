#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'poc_splunk_os_prereqs::disable_selinux'
include_recipe 'poc_splunk_os_prereqs::yum'
include_recipe 'poc_splunk_os_prereqs::python'
