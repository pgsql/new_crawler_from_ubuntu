class AddTimeOfLastRunToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :time_of_last_run, :datetime
  end

  def self.down
    remove_column :configurations, :time_of_last_run
  end
end
