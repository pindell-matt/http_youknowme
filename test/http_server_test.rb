require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require 'socket'
require 'pry'
require_relative '../lib/iter_0'

class HTTP_Server_Test < Minitest::Test
  attr_reader :client

  def setup
    @client = Hurley::Client.new "http://127.0.0.1:9292"
  end

  ## You can also use Hurley class level shortcuts, which use Hurley.default_client.
  ## response = Hurley.get("https://api.github.com/users/tater")

  def test_server_responds
    response = Hurley.get("http://120.0.0.1:9292")
    assert response.success?
  end
end
