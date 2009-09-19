class AddNameHiddenToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :name_hidden, :boolean
  end

  def self.down
    remove_column :reviews, :name_hidden
  end
end
