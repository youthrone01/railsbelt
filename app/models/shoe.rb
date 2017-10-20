class Shoe < ActiveRecord::Base
  belongs_to :user
  belongs_to :buyer, :foreign_key => "buyer_id", :class_name => "User"

  validates :name, :price, presence: true
end
