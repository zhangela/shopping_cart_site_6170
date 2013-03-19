class Item < ActiveRecord::Base
  attr_accessible :name, :price

  validates :price, :numericality => { :only_integer => true, :greater_than => 0 }


end
