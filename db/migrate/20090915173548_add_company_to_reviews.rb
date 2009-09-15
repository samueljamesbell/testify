class AddCompanyToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :company, :string
  end

  def self.down
    remove_column :reviews, :company
  end
end
