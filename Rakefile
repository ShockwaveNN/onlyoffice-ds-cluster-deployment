# frozen_string_literal: true

require_relative 'lib/onlyoffice_ds_cluster_depoyment.rb'

desc 'Create services server'
task :init_services do
  include OnlyofficeDsClusterDeployment
  init_services
end

desc 'Destroy all created services'
task :destroy_all do
  include OnlyofficeDsClusterDeployment
  destroy_all
end

task :test_psql do
  include OnlyofficeDsClusterDeployment
  logger.info("Test by `#{test_postgresql}`")
end

task :test_rabbitmq do
  include OnlyofficeDsClusterDeployment
  logger.info("Open `http://#{services_server_ip}:15672` and login")
end
