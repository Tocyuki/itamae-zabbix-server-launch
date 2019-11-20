node[:middlewares][:mysql].each do |pkg|
  package pkg[:url] do
    not_if "rpm -q #{pkg[:rpm]}"
  end

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
