class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cartitems, dependent: :destroy

  attr_accessible :user, :cartitems, :status


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


  def is_empty
    if cartitems.count == 0
      return true
    end
    return false
  end

  def set_status(newstat)
    self.status = newstat
    self.save
    puts "SELF STATUS"
    puts self.status
  end

end
