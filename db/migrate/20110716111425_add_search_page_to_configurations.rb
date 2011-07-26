class AddSearchPageToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :search_page, :boolean
  end

  def self.down
    remove_column :configurations, :search_page
  end
end
