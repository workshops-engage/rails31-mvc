class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :client
      t.date :start
      t.integer :hours
      t.text :team

      t.timestamps
    end
  end
end
