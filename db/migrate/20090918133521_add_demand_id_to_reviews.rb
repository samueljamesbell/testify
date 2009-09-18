class AddDemandIdToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :demand_id, :integer
  end

  def self.down
    remove_column :reviews, :demand_id
  end
end
