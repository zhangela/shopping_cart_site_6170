class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cartitems, dependent: :destroy

  attr_accessible :user, :cartitems


  def add_item(item_id)
    current_item = cartitems.find_by_item_id(item_id)
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      item = Item.find(item_id)
      current_item = cartitems.create(:item => item, :quantity => 1 )
      current_item.quantity = 1
    end
    return current_item
  end
end
