require 'socket'
require 'pry'
require 'time'

class Parser

  def initialize(path, request_count)
    @path = path
    @request_count = request_count
  end

  # Create CASE version
  # not really parsing, it's more pure path evaluation / client request
  # move back to response (or it's own) and initialize hello_count there
  def path_eval(path, request_count)
    if path == "/hello"
      "Hello, World! (#{request_count})"
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
