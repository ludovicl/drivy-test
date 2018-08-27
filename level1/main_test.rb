require 'json'
require_relative 'main'
require 'test/unit'

class MainTest < Test::Unit::TestCase
  def test_expected_output
    expected_data = JSON.parse(File.read('data/expected_output.json'))
    data = Main.execute('data/input.json')
    assert_equal(expected_data, data)
  end
end
