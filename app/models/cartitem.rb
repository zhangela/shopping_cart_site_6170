class Cartitem < ActiveRecord::Base
  belongs_to :item
  belongs_to :cart
  attr_accessible :quantity, :item_id, :item, :cart
end
