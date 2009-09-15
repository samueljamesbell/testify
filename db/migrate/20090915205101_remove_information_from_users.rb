class RemoveInformationFromUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :organisation
  	remove_column :users, :company
  end

  def self.down
    remove_column :users, :organisation
  	remove_column :users, :company
  end
end
