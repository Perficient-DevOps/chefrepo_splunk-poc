
default[:splunk][:is_server] = false

default[:splunk][:local_monitors] = [
  { path: '///var/log/syslog', index: 'default' },
  { path: '///var/log/dmesg', index: 'default' },
]
