class Tier < ApplicationRecord
  include RankedModel
  belongs_to :tier_list
  validates :title, presence: true, length: { maximum: 100 }
  validates :tier_list, presence: true

  # Needed for ranked_model gem
  ranks :row_order, with_same: :tier_list_id
end
