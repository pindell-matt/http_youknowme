require 'socket'
require 'pry'

class HTTP_Server
  attr_reader :server, :request_count

  def initialize
    @server = TCPServer.new(9293)
    @request_count = 0
  end

  def request
    loop do
      client = @server.accept
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      puts request_lines.join("\n")
      verb = request_lines[0].split[0]
      # binding.pry
      response(client, request_lines)
      break if @request_count == 10
      client.close
    end
  end

  def response(client, request_lines)
    diagnostics = [ "Verb: #{request_lines[0].split[0]}",
                    "Path: #{request_lines[0].split[1]}",
                    "Protocol: #{request_lines[0].split[2]}",
                    "Host: #{request_lines[1].split[1].split(":")[0]}",
                    "Port: #{request_lines[1].split[1].split(":")[1]}",
                    "Origin: #{request_lines[1].split[1].split(":")[0]}",
                    "Accept: #{request_lines[3].split[1]}"].join("\r\n")
    response = "<pre>" + "Hello, World! (#{@request_count})" + "\n\n" + diagnostics + "<pre>"
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
