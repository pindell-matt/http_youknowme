$LOAD_PATH.unshift(File.expand_path(".", __dir__))
require 'socket'
require 'pry'
require 'http_response'

class HTTP_Request
  attr_accessor :request_count

  def initialize
    @request_count = 0
  end

  def request(server)
    loop do
      client = server.accept
      lines = req_line_processor(client)
      path = lines[0].split[1]
      @request_count += 1
      response = HTTP_Reponse.new(path, request_count)
      response.respond(client, lines)
      break if path == "/shutdown"
      client.close
    end
  end

  def req_line_processor(client)
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    request_lines
  end
end
