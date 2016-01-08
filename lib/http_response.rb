$LOAD_PATH.unshift(File.expand_path(".", __dir__))
require 'socket'
require 'pry'
require 'time'
# require 'parser'
require 'request_parse'

class HTTP_Response
  attr_reader :request_count, :path

  def initialize(path, request_count, hello_count)
    @request_count = request_count
    @path = path
    @hello_count = hello_count
    # @parser = Parser.new(path, request_count, hello_count).path_eval.to_s
  end

  def respond(client, request_lines)
    diagnostics = Request_Parse.new(request_lines)
    response_body = path_eval
    response = "<pre>" + response_body + "\n\n" + diagnostics.parse_diagnostic + "<pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    client.puts headers(output)
    client.puts output
  end

  def headers(output)
    ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def path_eval
    if path == "/hello"
      "Hello, World! (#{@hello_count})"
    elsif path == "/datetime"
      now = Time.new
      now.strftime("%I:%M%p on %A, %B %d, %Y")
    elsif path == "/shutdown"
      "Total Requests: #{request_count}"
    else
      "No Path!"
    end
  end

end
