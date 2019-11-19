require 'spec_helper'

%w(mysql-community-devel mysql-community-server).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe service('mysqld') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end
