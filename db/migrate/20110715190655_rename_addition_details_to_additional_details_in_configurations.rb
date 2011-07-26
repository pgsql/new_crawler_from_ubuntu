class RenameAdditionDetailsToAdditionalDetailsInConfigurations < ActiveRecord::Migration
  def self.up
    rename_column :configurations, :addition_details,:additional_details
  end

  def self.down
    rename_column :configurations, :additional_details,:addition_details
  end
end
