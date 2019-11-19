require 'spec_helper'

%w(zabbix-server-mysql zabbix-web-mysql zabbix-agent).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w(zabbix-server zabbix-agent).each do |pkg|
  describe service(pkg) do
    it { should be_enabled }
    it { should be_running }
  end
end

describe port(10050) do
  it { should be_listening }
end
