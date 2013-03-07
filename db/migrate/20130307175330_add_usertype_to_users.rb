class AddUsertypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :usertype, :integer
  end
end
