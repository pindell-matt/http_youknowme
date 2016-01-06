require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'

class HTTP_Response_Test < Minitest::Test
  attr_reader :client

  def test_response_body
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "<html><head></head><body><pre>Hello, World!"
    assert_equal expected, response.body[0..42]
  end

  def test_response_status_code
    response = Hurley.get("http://127.0.0.1:9292")
    expected = 200
    assert_equal expected, response.status_code
  end

end
