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

      # this is the text!
      path = request_lines[0].split[1]
      puts path
      # this is the text!

      @request_count += 1
      response = HTTP_Reponse.new(path, request_count)
      response.respond(client, request_lines)

      break if path == "/shutdown"
      client.close
    end
  end


end
