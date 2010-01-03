require 'test_helper'

class LocaleyTest < ActiveSupport::TestCase

  test "tests are actually working" do
    Localey.new.filter_locale :foo => "bar"
  end

end
