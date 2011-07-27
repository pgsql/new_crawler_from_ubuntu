class AddResultsToDepartmentDescriptionToResults < ActiveRecord::Migration
  def self.up
    add_column :results, :department_description, :string
  end

  def self.down
    remove_column :results, :department_description
  end
end
