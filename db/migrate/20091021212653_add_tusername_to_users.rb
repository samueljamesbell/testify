class AddTusernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :tusername, :string
  end

  def self.down
    remove_column :users, :tusername
  end
end
