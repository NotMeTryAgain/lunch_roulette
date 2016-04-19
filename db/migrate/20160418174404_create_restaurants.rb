class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string "name", null: false
      t.string "category"
      t.string "address"
      t.string "city"
      t.string "state"
      t.string "zip"
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
