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

  def init_postgres
    init_file = "#{Dir.pwd}/lib/onlyoffice_ds_cluster_deployment/"\
                'postgresql_init.sh'
    send_file(services_server_ip, init_file)
    execute_ssh(services_server_ip, 'bash /root/postgresql_init.sh')
  end

  def init_rabbitmq
    init_file = "#{Dir.pwd}/lib/onlyoffice_ds_cluster_deployment/"\
                'rabbitmq_init.sh'
    send_file(services_server_ip, init_file)
    execute_ssh(services_server_ip, 'bash /root/rabbitmq_init.sh')
  end

  # Init all services
  def init_services
    create_services_server
    # init_postgres
    init_rabbitmq
  end

  # @return [String] test postgresql connection
  def test_postgresql
    "PGPASSWORD=onlyoffice psql -h #{services_server_ip} "\
    '-U onlyoffice onlyoffice'
  end
end
