#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: set_ulimits
#
# Copyright:: 2018, The Authors, All Rights Reserved.
user_ulimit "tomcat" do
  #filehandle_limit 8192 # optional
  filehandle_soft_limit 16240 # optional; not used if filehandle_limit is set)
  filehandle_hard_limit 16240 # optional; not used if filehandle_limit is set)
  # process_limit 61504 # optional
  # process_soft_limit 61504 # optional; not used if process_limit is set)
  # process_hard_limit 61504 # optional; not used if process_limit is set)
  # memory_limit 1024 # optional
  # core_limit 2048 # optional
  # core_soft_limit 1024 # optional
  # core_hard_limit 'unlimited' # optional
  # stack_soft_limit 2048 # optional
  # stack_hard_limit 2048 # optional
  # rtprio_limit 60 # optional
  # rtprio_soft_limit 60 # optional
  # rtprio_hard_limit 60 # optional
end
