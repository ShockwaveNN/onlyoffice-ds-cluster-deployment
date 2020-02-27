# frozen_string_literal: true

require 'onlyoffice_digitalocean_wrapper'
require_relative 'onlyoffice_ds_cluster_deployment/services_service'

# Working with deployment
module OnlyofficeDsClusterDeployment
  include ServicesServer

  # @return [String] name of servers created for cluster
  CLUSTER_NAME_PATTERN = 'scripted-ds-cluster'
  DROPLET_IMAGE = 'ubuntu-18-04-x64'
  DROPLET_REGION = 'nyc3'
  DROPLET_SIZE = '2gb'
  SSH_KEY_ID = ENV['DS_CLUSTER_DEPLOY_SSH_KEY_ID']
  # @return [OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper]
  #   api of DigitalOcean
  def do_api
    @do_api ||= OnlyofficeDigitaloceanWrapper::DigitalOceanWrapper.new
  end

  # @return [Logger] logger object
  def logger
    @logger ||= Logger.new(STDOUT)
  end
end
