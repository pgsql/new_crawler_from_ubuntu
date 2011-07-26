class AddDetailedDescriptionToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :detailed_description, :text
  end

  def self.down
    remove_column :results, :detailed_description
  end
end
