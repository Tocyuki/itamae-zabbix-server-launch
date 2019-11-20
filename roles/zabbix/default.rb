include_cookbook "apache"
include_cookbook "zabbix"
include_cookbook "mysql"

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