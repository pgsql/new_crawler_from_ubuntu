class RenameWorkingTimeToWorkingTitleFromConfigurations < ActiveRecord::Migration
  def self.up
     rename_column :configurations, :working_time,:working_title
  end

  def self.down
     rename_column :configurations, :working_title,:working_time
  end
end
