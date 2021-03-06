$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))
require 'socket'
require 'pry'
require 'http_request'

class HTTP_Server
  attr_reader :server

  def initialize
    @server = TCPServer.new(9292)
  end

  def request
    create_request = HTTP_Request.new
    create_request.request(server)
  end
end

if __FILE__ == $0
tcp_server = HTTP_Server.new
tcp_server.request
end
