#
# Cookbook Name:: redis
# Recipe:: _server_supervisor

redis_service = case node['platform_family']
when "debian"
  "redis-server"
when "rhel", "fedora"
  "redis"
else
  "redis"
end

supervisor_service "redis" do
  action :enable
  autostart true
  autorestart true
  user "redis"
  numprocs 1
  redirect_stderr true
  stopwaitsecs 10
  startsecs 10
  priority 999
  command "#{node['redis']['dst_dir']}/bin/redis-server"
  startretries 3
end