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

  def test_validate_layout
    config = {'rows' => 3, 'columns' => 0, 'width' => 1440, 'height' => 900, 'margin' => 10,
    'dashes' => {'test' => {'row' => 0, 'column' => 0, 'width' => 2, 'height' => 2}}}

    assert_raise ArgumentError do
      Dashboard::Board.new config
    end

    config['columns'] = 3
    dashboard = Dashboard::Board.new config

    assert_nothing_raised Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dash = {'row' => 0, 'column' => 2, 'width' => 1, 'height' => 3}
    dashboard.dashes << (Dashboard::Dash.new 'test_2', dash)

    assert_nothing_raised Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dashboard.dashes[1].width = 2

    assert_raise Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dashboard.dashes[1].width = 1
    dashboard.dashes[1].height = 4

    assert_raise Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dashboard.dashes[1].height = 0

    assert_raise Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dashboard.dashes[1].height = 3

    dash = {'row' => 2, 'column' => 0, 'width' => 2, 'height' => 1}
    dashboard.dashes << (Dashboard::Dash.new 'test_3', dash)

    assert_nothing_raised Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

    dashboard.rows = 0

    assert_raise Dashboard::LayoutError do
      Dashboard.validate_layout dashboard
    end

  end

  def test_initialization
    config = {'rows' => 2, 'columns' => 4, 'width' => 1440, 'height' => 900, 'margin' => 10}

    assert_raise ArgumentError do
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
    assert_equal 'Dashboard', dashboard.title, 'Did not specify dashboard title, should default to "Dashboard"'

    dashes = dashboard.dashes
    assert_equal 1, dashes.length, 'Should be only one dash in the dashboard list of dashes'

    dash = dashes[0]
    assert_equal 'test', dash.name
    assert_equal 1, dash.row
    assert_equal 1, dash.column
    assert_equal 2, dash.width
    assert_equal 2, dash.height
    assert_nil dash.refresh_rate, 'Did not specify refresh rate, should be nil'

    dash_data = dash.data
    assert_equal 1, dash_data.length, 'Should be only one key-value data pair for the dash'
    assert_equal 'value', dash_data['key']
  end
end
