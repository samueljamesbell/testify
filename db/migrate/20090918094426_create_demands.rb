class CreateDemands < ActiveRecord::Migration
  def self.up
    create_table :demands do |t|
      t.string :name
      t.string :company
      t.string :email
      t.string :code
      t.boolean :code_used
      t.integer :user_id
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :demands
  end
end
