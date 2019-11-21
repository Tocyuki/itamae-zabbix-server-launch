require 'spec_helper'
require 'zabbix/common_method'

  middleware_vars = {
    packages: [
      'zabbix-server-mysql',
      'zabbix-web-mysql',
      'zabbix-agent',
      'zabbix-get',
      'zabbix-web-japanese'
    ],
    processes: ['zabbix-server', 'zabbix-agent'],
    ports: [10050]
  }

setup_middlewares(middleware_vars)
