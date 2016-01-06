require 'minitest/autorun'
require 'minitest/pride'
require 'socket'
require 'hurley'
require 'pry'
# git push fix
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
  def test_diagnostics_verb
    response = Hurley.get("http://127.0.0.1:9292")
    binding.pry
    assert_equal expected, response.status_code
  end

  # test iteration 2 -> implement

end
