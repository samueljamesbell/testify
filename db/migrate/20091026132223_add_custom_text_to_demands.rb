class AddCustomTextToDemands < ActiveRecord::Migration
  def self.up
    add_column :demands, :custom_text, :text
  end

  def self.down
    remove_column :demands, :custom_text
  end
end
