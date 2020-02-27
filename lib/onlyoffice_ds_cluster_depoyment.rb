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

  # Destroy all created servers
  def destroy_all
    do_api.destroy_droplet_by_name(services_server_name)
  end

  # @param ip [String] ip of server to execute command
  # @param command [String] command to execute
  # @return [String] result of execution
  def execute_ssh(ip, command)
    `ssh -o StrictHostKeyChecking=no root@#{ip} "#{command}"`
    sleep(5) # Timeout between commands to not be banned by ssh
  end
end
