class DeleteDateModifiedDateCreatedFromResults < ActiveRecord::Migration
  def self.up
     remove_column :results, :date_modified
     remove_column :results, :date_created
  end

  def self.down
     add_column :results, :date_modified,:datetime
     add_column :results, :date_created , :datetime
  end
end
