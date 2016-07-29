class Review < ActiveRecord::Base
  validates :rating, presence: true
  validates :user_id, presence: true
  validates :product_id, presence: true
end
