require 'socket'
require 'pry'

class HTTP_Reponse

  def initialize

  end

  def respond(client, request_lines, request_count)
    diagnostics = [ "Verb: #{request_lines[0].split[0]}",
                    "Path: #{request_lines[0].split[1]}",
                    "Protocol: #{request_lines[0].split[2]}",
                    "Host: #{request_lines[1].split[1].split(":")[0]}",
                    "Port: #{request_lines[1].split[1].split(":")[1]}",
                    "Origin: #{request_lines[1].split[1].split(":")[0]}",
                    "Accept: #{request_lines[3].split[1]}"].join("\r\n")
    response = "<pre>" + "Hello, World! (#{request_count})" + "\n\n" + diagnostics + "<pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
  end
end
