#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: disable_transparent_hugepages
#
# Copyright:: 2018, The Authors, All Rights Reserved.

temp_script= File.join( Chef::Config[:file_cache_path], 'disable_hugepages.sh' )

template temp_script do
  source 'disable_hugepages.sh.erb'
  mode '0777'
  :create
end

execute 'Run Shell Script' do
  command "#{temp_script}"
end
