class AddTpasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :tpassword, :string
  end

  def self.down
    remove_column :users, :tpassword
  end
end
