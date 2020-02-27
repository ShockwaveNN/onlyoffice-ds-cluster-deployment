# frozen_string_literal: true

require_relative 'lib/onlyoffice_ds_cluster_depoyment.rb'

desc 'Create services server'
task :create_services_server do
  include OnlyofficeDsClusterDeployment
  create_services_server
end

desc 'Destroy all created services'
task :destroy_all do
  include OnlyofficeDsClusterDeployment
  destroy_all
end
