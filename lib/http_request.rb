require 'socket'
require 'pry'
require_relative 'http_response'

class HTTP_Request
  attr_accessor :request_count

  def initialize
    @request_count = 0
  end

  def request(server)
    loop do
      client = server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end

      response = HTTP_Reponse.new
      @request_count += 1
      response.respond(client, request_lines, request_count)

      client.close
    end
  end

end
