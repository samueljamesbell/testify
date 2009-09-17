class RemoveInformationFromUsers < ActiveRecord::Migration
  def self.up
  	remove_column :users, :organisation
  end

  def self.down
  end
end
