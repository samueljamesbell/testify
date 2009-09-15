class AddPageHolderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :page_holder, :boolean
  end

  def self.down
    remove_column :users, :page_holder
  end
end
