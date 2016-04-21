class AddNameToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :name, :string, null: false
  end
end
