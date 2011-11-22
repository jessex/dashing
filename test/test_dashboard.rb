require 'dashing/dashboard'
require 'test/unit'

class TestDashboard < Test::Unit::TestCase
  def test_validate_integer
    assert_raise ArgumentError do
      Dashboard.validate_integer :test, nil
    end

    assert_raise ArgumentError do
      Dashboard.validate_integer :test, 'not_integer'
    end

    assert_equal 5, Dashboard.validate_integer(:test, 5), 'Successful call to validate_integer should return value'
  end

  def test_initialization
    config = {'rows' => 2, 'columns' => 4, 'width' => 1440, 'height' => 900, 'margin' => 10}

    assert_raise NoMethodError do
      Dashboard::Board.new config
    end

    config['dashes'] = {'test' => {'row' => 1, 'column' => 1, 'width' => 2, 'height' => 2,
                                   'data' => {'key' => 'value'}}}

    dashboard = Dashboard::Board.new config
    assert_equal 2, dashboard.rows
    assert_equal 4, dashboard.columns
    assert_equal 1440, dashboard.width
    assert_equal 900, dashboard.height
    assert_equal 10, dashboard.margin
    assert_nil dashboard.color, 'Did not specify dashboard color, should be nil'

    dashes = dashboard.dashes
    assert_equal 1, dashes.length, 'Should be only one dash in the dashboard list of dashes'

    dash = dashes[0]
    assert_equal 'test', dash.name
    assert_equal 1, dash.row
    assert_equal 1, dash.column
    assert_equal 2, dash.width
    assert_equal 2, dash.height

    dash_data = dash.data
    assert_equal 1, dash_data.length, 'Should be only one key-value data pair for the dash'
    assert_equal 'value', dash_data['key']
  end
end
