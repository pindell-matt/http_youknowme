require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'

class HTTP_Response_Test < Minitest::Test
  attr_reader :client

  def test_response_body
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "Hello, World!"
    assert response.body.include?(expected)
  end

  def test_response_200_status_code
    response = Hurley.get("http://127.0.0.1:9292")
    expected = 200
    assert_equal expected, response.status_code
  end

  # test diagnostics
  def test_diagnostic_verb
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "GET"
    assert_equal expected, response.body.split("\n")[2].split[1]
  end

  def test_diagnostic_path
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "/"
    assert_equal expected, response.body.split("\n")[3].split[1]
  end

  def test_diagnostic_protocol
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "HTTP/1.1"
    assert_equal expected, response.body.split("\n")[4].split[1]
  end

  def test_diagnostic_host
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "Hurley"
    assert_equal expected, response.body.split("\n")[5].split[1]
  end

  def test_diagnostic_port
    skip
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "9292"
    assert_equals expected, response.body[0]
  end

  def test_diagnostic_origin
    skip
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "GET"
    assert response.body.include?(expected)
  end

  def test_diagnostic_accept
    skip
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
    assert response.body.include?(expected)
  end

  # test iteration 2 -> implement

end
