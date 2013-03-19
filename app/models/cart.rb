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
    return (cartitems.count == 0)
  end

  def set_status(newstat)
    self.status = newstat
    self.save
  end

  def submit
    if self.status == 0 or self.status == 10
      self.set_status(1)
      self.save
    end
  end

  def save_cart
    if self.status == 0
      self.set_status(10)
      self.save
    end
  end

  def approve
    if self.status == 1
      self.set_status(2)
      self.save
    end
  end

  def deny
    if self.status == 1
      self.set_status(-1)
      self.save
    end
  end

end
