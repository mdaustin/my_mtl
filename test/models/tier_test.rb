require "test_helper"

class TierTest < ActiveSupport::TestCase
  def setup 
    @tier = tiers(:one)
    @user = users(:matthew)
  end

  test "should be valid" do
    assert @tier.valid?
  end

  test "tier_list_id should be present" do
    @tier.tier_list_id = nil
    assert_not @tier.valid?
  end

  test "title should be present" do
    @tier.title = " "
    assert_not @tier.valid?
  end

  test "title should not be too long" do
    @tier.title = "a" * 101
    assert_not @tier.valid?
  end

  test "tier should be ordered by row_order" do
    assert_equal @tier, @tier.tier_list.tiers.rank(:row_order).first
  end
end
