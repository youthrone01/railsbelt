class AddDateColumnToShoes < ActiveRecord::Migration
  def change
    add_column :shoes, :date, :date
  end
end
