class AddTimeRanToConfigurations < ActiveRecord::Migration
  def self.up
    add_column :configurations, :time_ran, :integer
  end

  def self.down
    remove_column :configurations, :time_ran
  end
end
