class AddWorkToDemands < ActiveRecord::Migration
  def self.up
    add_column :demands, :work, :string
  end

  def self.down
    remove_column :demands, :work
  end
end
