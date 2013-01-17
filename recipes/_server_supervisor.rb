#
# Cookbook Name:: redis
# Recipe:: _server_supervisor

# NOTE:
# be sure to set node[:config][:daemonize] = 'no' if using
# this recipe!

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
  command "#{node['redis']['dst_dir']}/bin/redis-server #{node['redis']['conf_dir']}/redis.conf"
  startretries 3
end