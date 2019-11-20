node[:middlewares][:zabbix].each do |pkg|
  package pkg[:url] do
    not_if "rpm -q #{pkg[:rpm]}"
  end

  execute "yum clean all"

  pkg[:modules].each do |mod|
    package mod do
      action :install
    end
  end

  pkg[:processes].each do |proc|
    service proc do
      action [:start, :enable]
      name proc
    end
  end
end


file "/etc/php.ini" do
  action :edit
  block do |content|
    content.gsub!(";date.timezone =", "date.timezone = Asia/Tokyo")
  end
end
