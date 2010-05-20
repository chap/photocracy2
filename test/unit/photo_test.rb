require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  should "be valid with factory" do
    assert_valid Factory.build(:photos)
  end
end
