class AddWorkToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :work, :string
  end

  def self.down
    remove_column :reviews, :work
  end
end
