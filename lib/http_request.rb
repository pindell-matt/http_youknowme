$LOAD_PATH.unshift(File.expand_path(".", __dir__))
require 'socket'
require 'pry'
require 'http_response'

class HTTP_Request
  attr_accessor :request_count, :hello_count

  def initialize
    @request_count = 0
    @hello_count = 0
  end

  def request(server)
    loop do
      client = server.accept
      request_lines = req_line_processor(client)
      path = request_lines[0].split[1]

      value = request_lines[0].split[1].split("?")[1].split("=")[1] if !request_lines[0].split[1].split("?")[1].nil?
      puts value

      @request_count += 1
      response = HTTP_Response.new(path, request_count, hello_count, value)
      response.respond(client, request_lines)
      break if contingencies(path)
      if path == "/hello"
        @hello_count += 1
      end
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

  def contingencies(path)
    path == "/shutdown"
  end
end
