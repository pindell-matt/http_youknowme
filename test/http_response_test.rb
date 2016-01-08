require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'time'
require 'pry'

class HTTP_Response_Test < Minitest::Test
  attr_reader :client

  def test_hello_world
    response = Hurley.get("http://127.0.0.1:9292/hello")
    expected = "Hello, World!"
    assert response.body.include?(expected)
  end

  def test_full_response_hello
   client = Hurley::Client.new("http://127.0.0.1:9292")
   response = client.get("/hello")
   expected = "Path: /hello Protocol: HTTP/1.1 Host: Hurley Port:  Origin: Hurley"
   received = response.body[49..-33].gsub("\n", "").gsub("\r", " ")
   assert_equal expected, received
  end

  def test_date_time
    response = Hurley.get("http://127.0.0.1:9292/datetime")
    now = Time.new
    expected = now.strftime("%I:%M%p on %A, %B %d, %Y")
    assert response.body.include?(expected)
  end

  def test_full_response_datetime
   client = Hurley::Client.new("http://127.0.0.1:9292")
   response = client.get("/datetime")
   now = Time.new
   time = now.strftime("%I:%M%p on %A, %B %d, %Y")
   expected = time + "Path: /datetime Protocol: HTTP/1.1 Host: Hurley Port:  Origin: Hurley"
   received = response.body[30..-33].gsub("\n", "").gsub("\r", " ")
   assert_equal expected, received
  end

  def test_response_200_status_code
    response = Hurley.get("http://127.0.0.1:9292")
    expected = 200
    assert_equal expected, response.status_code
  end

  def test_response_verb_no_path
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/")
    expected = "GET"
    assert response.inspect.include?(expected)
  end

  def test_full_request_no_path
   client = Hurley::Client.new("http://127.0.0.1:9292")
   response = client.get("/")
   expected = "Path: / Protocol: HTTP/1.1 Host: Hurley Port:  Origin: Hurley"
   received = response.body[30..-33].gsub("\n", "").gsub("\r", " ")
   assert_equal expected, received
  end

  def test_diagnostic_protocol
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "HTTP/1.1"
    received = response.body.split[4]
    assert_equal expected, received
  end

  def test_diagnostic_host
    response = Hurley.get("http://127.0.0.1:9292")
    expected = "Hurley"
    received = response.body.split[6]
    assert_equal expected, received
  end

  def test_real_word
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/word_search?word=happy")
    expected = "HAPPY is a known word"
    assert response.body.include?(expected)
  end

  def test_not_real_word
    client = Hurley::Client.new("http://127.0.0.1:9292")
    response = client.get("/word_search?word=zomblecom")
    expected = "ZOMBLECOM is not a known word"
    assert response.body.include?(expected)
  end

end
