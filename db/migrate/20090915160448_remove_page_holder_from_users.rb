class RemovePageHolderFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :page_holder
  end

  def self.down
    remove_column :users, :page_holder
  end
end
