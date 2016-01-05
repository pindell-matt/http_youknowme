require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'hurley'
require 'socket'
require 'pry'
require_relative '../lib/iteration_0'

class HTTP_Server_Test < Minitest::Test
  attr_reader :client

  def setup
    @client = Hurley::Client.new "http://127.0.0.1:9292/"
  end

  def test_server_is_open

  end

end
