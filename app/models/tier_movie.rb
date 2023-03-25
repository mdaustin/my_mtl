class TierMovie < ApplicationRecord
  include RankedModel
  belongs_to :tier
  belongs_to :movie

  validates :tier_id, presence: true
  validates :movie_id, presence: true

  validates :movie_id, uniqueness: { scope: :tier_id }

   # Needed for ranked_model gem
  ranks :row_order, with_same: :tier_id
end