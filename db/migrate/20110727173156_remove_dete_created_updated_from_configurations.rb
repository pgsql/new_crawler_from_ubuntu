class RemoveDeteCreatedUpdatedFromConfigurations < ActiveRecord::Migration
  def self.up
    remove_column :configurations, :date_modified
    remove_column :configurations, :date_created
  end

  def self.down
    add_column :configurations, :date_modified,:datetime
    add_column :configurations, :date_created , :datetime
  end
end
