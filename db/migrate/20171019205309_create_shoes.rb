class CreateShoes < ActiveRecord::Migration
  def change
    create_table :shoes do |t|
      t.string :name
      t.integer :price
      t.references :user, index: true, foreign_key: true
      t.integer :buyer_id

      t.timestamps null: false
    end
  end
end
