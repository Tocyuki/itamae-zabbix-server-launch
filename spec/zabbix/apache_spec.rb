require 'spec_helper'

middleware_vars = {
  packages: [
    "httpd"
  ],
  processes: [
    "httpd"
  ],
  ports: [
    80
  ]
}

middleware_vars[:packages].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

middleware_vars[:processes].each do |proc|
  describe service(proc) do
    it { should be_enabled }
    it { should be_running }
  end
end

middleware_vars[:ports].each do |port|
  describe port(port) do
    it { should be_listening }
  end
end
