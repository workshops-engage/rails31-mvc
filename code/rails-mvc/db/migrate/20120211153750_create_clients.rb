class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.string :state
      t.string :password

      t.timestamps
    end
  end
end
