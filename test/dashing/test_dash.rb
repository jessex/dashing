require 'dashing/dash'
require 'test/unit'

class TestDash < Test::Unit::TestCase
  def test_validate_none_nil
    data = {'key' => 'value', 'anotherKey' => 5}
    fields = ['key', 'anotherKey']
    assert_nothing_raised Dash::DashConfigurationError do
      Dash.validate_none_nil 'dash', data, fields
    end

    data['oneMoreKey'] = nil
    assert_nothing_raised Dash::DashConfigurationError do
      Dash.validate_none_nil 'dash', data, fields
    end

    fields << 'oneMoreKey'
    assert_raise Dash::DashConfigurationError do
      Dash.validate_none_nil 'dash', data, fields
    end
  end
end
