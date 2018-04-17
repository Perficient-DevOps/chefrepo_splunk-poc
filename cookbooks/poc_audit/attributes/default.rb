default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'

case node['os']
when 'linux'
  default['audit']['profiles'] = [
   {
      'name': 'DevSec Linux Security Baseline',
      'compliance': 'admin/linux-baseline'
    }
  ]
  when 'windows'
  default['audit']['profiles'] = [
    {
      'name': 'DevSec Windows Security Baseline',
      'compliance': 'admin/windows-baseline'
    }
  ]
end
