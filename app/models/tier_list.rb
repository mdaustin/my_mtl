class TierList < ApplicationRecord
  belongs_to :user
  has_many :tiers, dependent: :destroy
  validates :user_id, presence: true
  validates :title , presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 160 }
end
