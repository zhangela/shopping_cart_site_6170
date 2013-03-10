class AddStatusToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :status, :integer, :default => 0
  end
end
