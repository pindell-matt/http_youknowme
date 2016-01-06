require 'socket'
require 'pry'

class HTTP_Server
  attr_reader :server, :request_count

  def initialize
    @server = TCPServer.new(9292)
    @request_count = 0
  end

  def request
    loop do
      client = @server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      response(client)
      break if @request_count == 10
      client.close
    end
  end

  def response(client)
    response = "<pre>" + "Hello, World! (#{@request_count})"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
    @request_count += 1
  end

  def close
    client.close
  end
end

tcp_server = HTTP_Server.new
tcp_server.request
