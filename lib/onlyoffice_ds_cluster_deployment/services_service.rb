# frozen_string_literal: true

# Module for services server
module ServicesServer
  # @return [String] name of services server
  def services_server_name
    "#{CLUSTER_NAME_PATTERN}-services"
  end

  # Create server with services
  def create_services_server
    droplet = DropletKit::Droplet.new(name: services_server_name,
                                      region: DROPLET_REGION,
                                      image: DROPLET_IMAGE,
                                      size: DROPLET_SIZE,
                                      ssh_keys: [SSH_KEY_ID])
    do_api.client.droplets.create(droplet)
    do_api.wait_until_droplet_have_status(services_server_name)
  end

  # @return [True, False] is services server created
  def services_server_created?
    !do_api.get_droplet_id_by_name(services_server_name).nil?
  end
end
