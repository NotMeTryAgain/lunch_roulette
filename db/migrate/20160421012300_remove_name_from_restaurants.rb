class RemoveNameFromRestaurants < ActiveRecord::Migration
  def change
    remove_column :restaurants, :name, :string
    remove_column :restaurants, :location, :string
    remove_column :restaurants, :category, :string
    remove_column :restaurants, :user_id, :string
  end
end
