require 'socket'
require 'pry'
require_relative 'http_request'

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

tcp_server = HTTP_Server.new
tcp_server.request
