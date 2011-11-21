require 'dashboard'
require 'test/unit'

class TestDashboard < Test::Unit::TestCase
  def test_validate_integer
    assert_raise ArgumentError do
      Dashboard.validate_integer :test, nil
    end

    assert_raise ArgumentError do
      Dashboard.validate_integer :test, 'not_integer'
    end

    assert_equal(5, Dashboard.validate_integer(:test, 5), 'Successful call to validate_integer should return value')
    end
end
