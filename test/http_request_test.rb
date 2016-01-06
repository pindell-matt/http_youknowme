require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
require_relative '../lib/http_request'

class HTTP_Request_Test < Minitest::Test
  attr_reader :client

  # def test_response_body
  #   response = Hurley.get("http://127.0.0.1:9292")
  #   expected = "<html><head></head><body><pre>Hello, World!"
  #   assert_equal expected, response.body[0..42]
  # end

  def test_something
    client = Hurley::Client.new("http://127.0.0.1:9292")
    binding.pry
  end

end
