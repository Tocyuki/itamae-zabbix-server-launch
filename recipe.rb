package "https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm" do
    not_if "zabbix-release-4.0-2.el7.noarch"
end

execute "yum clean all"

%w(zabbix-server-mysql zabbix-web-mysql zabbix-agent).each do |pkg|
    package pkg do
        action :install
    end
end
