require 'test_helper'
require 'localey'
require 'i18n'

class LocaleyTest < Test::Unit::TestCase
  
  def setup
    @app = Localey.new Object.new
    @env = {}
    I18n.locale = :en
  end
  
  def test_filtering_a_basic_url_with_a_simple_locale
    set_path_info_and_filter( "/de/foo/bar" )
    assert_equal "/foo/bar", @env['PATH_INFO']
    assert_equal :de, I18n.locale
  end
  
  def test_filtering_a_basic_url_with_a_multipart_locale
    set_path_info_and_filter( "/en-US/foo/bar" )
    assert_equal "/foo/bar", @env['PATH_INFO']
    assert_equal :"en-US", I18n.locale
  end
  
  
  def set_path_info_and_filter path
    @env['PATH_INFO'] = path
    @app.filter_locale( @env )
  end
end
