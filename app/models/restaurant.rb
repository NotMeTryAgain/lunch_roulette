class Restaurant < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  validates :category, length: { maximum: 30 }
  validates :address, length: { maximum: 50 }
  validates :city, length: { maximum: 30 }
  validates :state, length: { maximum: 2 }
  validates :zip, length: { maximum: 5 }
end
