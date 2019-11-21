require 'spec_helper'
require 'zabbix/common_method'

  middleware_vars = {
    packages: ['httpd'],
    processes: ['httpd'],
    ports: [80]
  }

setup_middlewares(middleware_vars)
