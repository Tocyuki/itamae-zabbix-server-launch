package "marinadb-libs" do
  action :remove
end

package "https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm" do
  not_if "rpm -q zabbix-release-4.0-2.el7.noarch"
end

package "https://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm" do
  not_if "rpm -q mysql57-community-release-el7-7.noarch"
end

execute "yum clean all"

%w(zabbix-server-mysql zabbix-web-mysql zabbix-agent mysql-community-devel mysql-community-server).each do |pkg|
  package pkg do
    action :install
  end
end

file "/etc/php.ini" do
  action :edit
  block do |content|
    content.gsub!(";date.timezone =", "date.timezone = Asia/Tokyo")
  end
end

%w(zabbix-server zabbix-agent httpd mysqld).each do |pkg|
  service pkg do
    action [:start, :enable]
    name pkg
  end
end

execute 'Set root password and create zabbix database and user' do
  command <<-EOL
    tmp_pass=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}' | tail -n1) &&
    mysql -u root -p${tmp_pass} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'P@ssw0rd';" &&
    mysql -u root -pP@ssw0rd -e 'create database zabbix character set utf8 collate utf8_bin;' &&
    mysql -u root -pP@ssw0rd -e 'grant all privileges on zabbix.* to zabbix@localhost identified by "P@ssw0rd";' &&
    zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pP@ssw0rd zabbix
  EOL
  not_if "mysql -u root -pP@ssw0rd -e 'show tables from zabbix;'"
end
