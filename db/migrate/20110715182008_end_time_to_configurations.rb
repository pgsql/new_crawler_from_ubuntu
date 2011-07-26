class EndTimeToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :end_time, :datetime
  end

  def self.down
    remove_column :configurations, :end_time
  end
end
