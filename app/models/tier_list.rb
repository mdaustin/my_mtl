class TierList < ApplicationRecord
  belongs_to :user
  has_many :tiers, dependent: :destroy
  validates :user_id, presence: true
  validates :title , presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 160 }

  # Create a default tier for the search results
  def search_results_tier
    tiers.find_or_create_by(title: "Search Results")
  end
end
