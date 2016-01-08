$LOAD_PATH.unshift(File.expand_path(".", __dir__))
require 'socket'
require 'pry'
require 'time'
require 'parser'
require 'request_parse'

class HTTP_Response
  attr_reader :request_count, :parser
  attr_accessor :hello_count

  def initialize(path, request_count)
    @request_count = request_count
    @hello_count = 0
    @parser = Parser.new(path, request_count, hello_count).path_eval.to_s
  end

  def respond(client, request_lines)
    diagnostics = Request_Parse.new(request_lines)
    response = "<pre>" + parser + "\n\n" + diagnostics.parse_diagnostic + "<pre>"
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
end
