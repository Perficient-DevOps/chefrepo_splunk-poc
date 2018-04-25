#
# Cookbook:: poc_splunk_os_prereqs
# Recipe:: set_firewall
#
# Copyright:: 2018, The Authors, All Rights Reserved.

port_numbers = %w(8000 8080 8089 9997 9996)

execute port_numbers.each do |port_number|
  tcp_firewall_command = "firewall-cmd --zone=public --permanent --add-port=#{port_number}/tcp"
  command = tcp_firewall_command
end
