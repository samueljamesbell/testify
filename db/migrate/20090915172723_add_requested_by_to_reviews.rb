class AddRequestedByToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :requested_by, :integer
  end

  def self.down
    remove_column :reviews, :requested_by
  end
end
