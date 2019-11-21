require 'spec_helper'
require 'zabbix/common_method'

  middleware_vars = {
    packages: ['mysql-community-devel', 'mysql-community-server'],
    processes: ['mysqld'],
    ports: [3306]
  }

setup_middlewares(middleware_vars)
