class AddPageIdToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :page_id, :integer
  end

  def self.down
    remove_column :reviews, :page_id
  end
end
