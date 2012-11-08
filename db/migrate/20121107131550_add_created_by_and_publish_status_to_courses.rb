class AddCreatedByAndPublishStatusToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :created_by, :integer, :null => false, :default => 0
    change_column_default(:courses, :created_by, nil)
    
    add_column :courses, :publish_status, :string, :null => false, :default => ""
    change_column_default(:courses, :publish_status, nil)

    add_index :courses, :created_by
    add_index :courses, [:created_by, :publish_status]
  end
end
