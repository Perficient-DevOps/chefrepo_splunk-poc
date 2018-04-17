# # encoding: utf-8

# Check for:
#  * install directory
#  * running process

# Check SplunkUniversalForwarder
describe file( '/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder' ) do
 it { should be_directory }
 it { should be_owned_by 'splunk' }
end

describe file( '/opt/splunkforwarder/etc/apps/SplunkUniversalForwarder/local' ) do
 it { should be_directory }
 it { should be_owned_by 'splunk' }
end

# describe processes( Regexp.new('^splunkd .*$' ) ) do
describe processes( Regexp.new('^splunkd -p 8089 restart$' ) ) do
  # TODO: Should this be running as splunk user?
  its('users') { should include 'root' }
  its('commands') { should match ["splunkd -p 8089 restart"] }
end

# describe port(8089) do
#   it { should be_listening }
#   #its('processes') {should include 'splunkd'}
# end
