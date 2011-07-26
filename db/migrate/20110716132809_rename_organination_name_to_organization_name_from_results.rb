class RenameOrganinationNameToOrganizationNameFromResults < ActiveRecord::Migration
  def self.up
    rename_column :results, :organination_name,:organization_name
  end

  def self.down
    rename_column :results, :organization_name,:organination_name
  end
end
