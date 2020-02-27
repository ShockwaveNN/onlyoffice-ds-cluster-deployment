# frozen_string_literal: true

# Module for services server
module ServicesServer
  # @return [String] name of services server
  def services_server_name
    "#{CLUSTER_NAME_PATTERN}-services"
  end

  # @return [String] ip of services server
  def services_server_ip
    @services_server_ip ||= do_api.get_droplet_ip_by_name(services_server_name)
  end

  # Create server with services
  def create_services_server
    return if services_server_created?

    droplet = DropletKit::Droplet.new(name: services_server_name,
                                      region: DROPLET_REGION,
                                      image: DROPLET_IMAGE,
                                      size: DROPLET_SIZE,
                                      ssh_keys: [SSH_KEY_ID])
    do_api.client.droplets.create(droplet)
    do_api.wait_until_droplet_have_status(services_server_name)
    sleep(30) # wait for ssh to bootup
  end

  # @return [True, False] is services server created
  def services_server_created?
    !do_api.get_droplet_id_by_name(services_server_name).nil?
  end

  # Install postgresql and configure it
  def install_postgres
    execute_ssh(services_server_ip, 'apt-get -y update')
    execute_ssh(services_server_ip, 'apt-get -y install postgresql-10')
    replace_postgre_listen = 'sed -i \"s/.*listen_addresses.*/'\
                             'listen_addresses=\'*\'/\" '\
                             '/etc/postgresql/10/main/postgresql.conf'
    execute_ssh(services_server_ip, replace_postgre_listen)
  end

  # Init all services
  def init_services
    create_services_server
    install_postgres
  end
end
