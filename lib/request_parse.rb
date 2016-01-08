require 'socket'
require 'pry'
require 'time'

class Request_Parse
  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def parse_diagnostic
    ["Path: #{request_lines[0].split[1]}",
    "Protocol: #{request_lines[0].split[2]}",
    "Host: #{request_lines[1].split[1].split(":")[0]}",
    "Port: #{request_lines[1].split[1].split(":")[1]}",
    "Origin: #{request_lines[1].split[1].split(":")[0]}",
    "Accept: #{request_lines[3].split[1]}"].join("\r\n")
  end
end
