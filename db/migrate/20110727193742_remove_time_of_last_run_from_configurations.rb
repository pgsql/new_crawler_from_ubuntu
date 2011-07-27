class RemoveTimeOfLastRunFromConfigurations < ActiveRecord::Migration
  def self.up
    remove_column :configurations, :time_of_last_run
  end

  def self.down
    add_column :configurations, :time_of_last_run, :time
  end
end
