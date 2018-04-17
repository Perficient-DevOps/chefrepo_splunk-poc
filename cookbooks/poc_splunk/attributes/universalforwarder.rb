
default[:splunk][:is_server] = false

default[:splunk][:local_monitors] = [
  { path: '///var/log/syslog', index: 'default' },
  { path: '///var/log/dmesg', index: 'default' },
  { path: '///var/log/secure', index: 'default' },
  { path: '////var/log/yum.log', index: 'default'},
]
