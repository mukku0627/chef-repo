#
# Cookbook Name:: hello
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
log "Hello, Chef!"

%w{zsh git tmux php54 nginx php54-fpm rubygems}.each do |pkg|
    package pkg do
        action :install
    end
end

template "nginx.conf" do
    path "/etc/nginx/nginx.conf"
    source "nginx.conf.erb"
    owner "root"
    group "root"
    mode 644
    notifies :reload, 'service[nginx]'
end
template "www.conf" do
    path "/etc/php-fpm.d/www.conf"
    source "www.conf.erb"
    owner "root"
    group "root"
    mode 644
    notifies :reload, 'service[php-fpm]'
end

service "php-fpm" do
    supports :status=>true, :restart=>true, :reload=>true
    action [:enable, :start]
end
service "nginx" do
    supports :status=>true, :restart=>true, :reload=>true
    action [:enable, :start]
end
