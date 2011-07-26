class ChangeLastRunFromConfigurationsToTime < ActiveRecord::Migration
  def self.up
    change_column :configurations, :last_run, :time
  end

  def self.down
    change_column :configurations, :last_run, :date
  end
end
