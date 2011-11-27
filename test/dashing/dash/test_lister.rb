require 'dashing/dash'
require 'dashing/dash/lister'
require 'test/unit'

class TestLister < Test::Unit::TestCase
  def test_get_erb_locals
    data = {'title' => 'Test List'}
    lister = Lister.new

    assert_raise Dash::DashConfigurationError do
      lister.get_erb_locals data
    end

    data['list'] = ['Item 1', 'Item 2', 'Item 3']
    assert_nothing_raised Dash::DashConfigurationError do
      locals = lister.get_erb_locals data
      assert_equal 'Test List', locals[:title]
      assert_equal 3, locals[:list].length
      assert_equal false, locals[:ordered]
    end

    data['ordered'] = true
    assert_nothing_raised Dash::DashConfigurationError do
      locals = lister.get_erb_locals data
      assert_equal 'Test List', locals[:title]
      assert_equal 3, locals[:list].size
      assert_equal true, locals[:ordered]
    end
  end
end
