class ChangeFirstToTinyIntegerInConfigurations < ActiveRecord::Migration
  def self.up
    change_column :configurations, :first_time, :integer
  end

  def self.down
    change_column :configurations, :first_time, :boolean
  end
end
