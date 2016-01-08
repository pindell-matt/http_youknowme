require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
require_relative '../lib/http_request'

class HTTP_Request_Test < Minitest::Test
  attr_reader :client

end
