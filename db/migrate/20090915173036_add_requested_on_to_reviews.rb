class AddRequestedOnToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :requested_on, :datetime
  end

  def self.down
    remove_column :reviews, :requested_on
  end
end
