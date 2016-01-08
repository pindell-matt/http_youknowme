require 'socket'
require 'pry'
require 'time'

class Parser
  attr_reader :path, :request_count
  attr_accessor :hello_count

  def initialize(path, request_count, hello_count)
    @path = path
    @request_count = request_count
    @hello_count = hello_count
  end

  # move back to response (or it's own) and initialize hello_count there
  def path_eval
    if path == "/hello"
      response = "Hello, World! (#{@hello_count})"
      @hello_count += 1
      response
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
