require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
require_relative '../lib/http_request'

class HTTP_Request_Test < Minitest::Test
  attr_reader :client

  def test_full_request_hello_verb
    client = Hurley::Client.new("http://127.0.0.1:9292")
    request = client.get("/hello")
    expected = "GET"
    received = request.inspect.split[1]
    binding.pry
    assert_equal expected, received
  end

end
