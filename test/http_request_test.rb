require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
require_relative '../lib/http_request'

class HTTP_Request_Test < Minitest::Test
  attr_reader :client

  def test_something
    client = Hurley::Client.new("http://127.0.0.1:9292")
  end

end
