class CreateCartitems < ActiveRecord::Migration
  def change
    create_table :cartitems do |t|
      t.integer :quantity
      t.references :item
      t.references :cart

      t.timestamps
    end
    add_index :cartitems, :item_id
    add_index :cartitems, :cart_id
  end
end
