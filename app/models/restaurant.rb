class Restaurant < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :address, length: { maximum: 50 }
  validates :category, length: { maximum: 30 }
  validates :comments, length: { maximum: 140 }
end
