class AddFixedCriteriaToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :value_for_money, :integer
    add_column :reviews, :time_management, :integer
    add_column :reviews, :customer_service, :integer
    add_column :reviews, :quality_of_service, :integer
  end

  def self.down
    remove_column :reviews, :quality_of_service
    remove_column :reviews, :customer_service
    remove_column :reviews, :time_management
    remove_column :reviews, :value_for_money
  end
end
