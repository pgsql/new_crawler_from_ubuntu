class RenameDepartmentDescriptionToDepartmentCreationFromConfigurations < ActiveRecord::Migration
  def self.up
     rename_column :configurations, :department_creation,:department_description
  end

  def self.down
    rename_column :configurations, :department_description,:department_creation
  end
end
