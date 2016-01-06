require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'

class HTTP_Server_Test < Minitest::Test
  attr_reader :client

  def test_server_responds
    response = Hurley.get("http://127.0.0.1:9292")
    assert response.success?
  end

  def test_scheme
    client = Hurley::Client.new("http://127.0.0.1:9292")
    assert_equal "http", client.scheme
  end

  def test_host
    client = Hurley::Client.new("http://127.0.0.1:9292")
    assert_equal "127.0.0.1", client.host
  end

  def test_port
    client = Hurley::Client.new("http://127.0.0.1:9292")
    assert_equal 9292, client.port
  end

end
