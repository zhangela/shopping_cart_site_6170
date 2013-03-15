class Cartitem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart
  attr_accessible :quantity, :item, :cart

  validates :quantity, :numericality => { :only_integer => true, :greater_than => 0 }
end
