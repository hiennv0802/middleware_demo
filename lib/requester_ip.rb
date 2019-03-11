class RequesterIp
  require 'socket'

  def initialize app
    @app = app
  end

  def call env
    status, headers, body = @app.call env
    user_ip = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address

    logger = Logger.new Rails.root.join("log", "requester_ip_log.log")
    logger.info("Requester user at: #{Time.now}, with ip: #{user_ip}")
    puts "Welcome to my middleware test"

    [status, headers, body]
  end
end
