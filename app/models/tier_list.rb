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

  # Count the number of movies on the tier list
  def total_movie_count
    tiers.where.not(title: "Search Results").joins(:movies).count
  end

  # Get the total runtime of all movies on the tier list
  def total_runtime
    tiers.where.not(title: "Search Results").joins(:movies).sum(:runtime)
  end

  # Get total runtime in hours
  def total_runtime_hours
    total_runtime / 60
  end
end
