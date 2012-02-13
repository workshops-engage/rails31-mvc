class AddAreaToHouses < ActiveRecord::Migration
  def change
    add_column :houses, :area, :integer
  end
end
