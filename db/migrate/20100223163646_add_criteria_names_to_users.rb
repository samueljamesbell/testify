class AddCriteriaNamesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :time_management_name, :string, :default => "Time management"
    add_column :users, :customer_service_name, :string, :default => "Customer service"
    add_column :users, :value_for_money_name, :string, :default => "Value for money"
    add_column :users, :quality_of_service_name, :string, :default => "Overall quality"
  end

  def self.down
    remove_column :users, :time_management_name
    remove_column :users, :customer_service_name
    remove_column :users, :value_for_money_name
    remove_column :users, :quality_of_service_name
  end
end
