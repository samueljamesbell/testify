class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.string :object_type
      t.integer :object_id
      t.string :action_type
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :actions
  end
end
