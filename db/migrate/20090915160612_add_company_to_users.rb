class AddCompanyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :company, :boolean
  end

  def self.down
    remove_column :users, :company
  end
end
