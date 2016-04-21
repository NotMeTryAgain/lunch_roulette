class AddUserRefToRestaurants < ActiveRecord::Migration
  def change
    add_reference :restaurants, :user, index: true,
    foreign_key: true, null: false
  end
end
