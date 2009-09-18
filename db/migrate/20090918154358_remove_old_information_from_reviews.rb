class RemoveOldInformationFromReviews < ActiveRecord::Migration
  def self.up
  	remove_column :reviews, :page_id
  	remove_column :reviews, :requested_by
  	remove_column :reviews, :requested_on
  end

  def self.down
  end
end
