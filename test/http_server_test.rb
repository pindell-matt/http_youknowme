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

  # def test_response_body
  #   response = Hurley.get("http://127.0.0.1:9292")
  #   expected = "<html><head></head><body><pre>Hello, World! (1)</body></html>"
  #   assert_equal expected, response.body
  # end

  def test_response_body
    response = Hurley.get("http://127.0.0.1:9292")
    binding.pry
  end

end
