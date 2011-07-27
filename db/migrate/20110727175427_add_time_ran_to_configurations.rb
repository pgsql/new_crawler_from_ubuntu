class AddTimeRanToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :time_ran, :float
  end

  def self.down
    remove_column :configurations, :time_ran
  end
end
