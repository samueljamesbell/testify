class AddCompanyHiddenToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :company_hidden, :boolean
  end

  def self.down
    remove_column :reviews, :company_hidden
  end
end
