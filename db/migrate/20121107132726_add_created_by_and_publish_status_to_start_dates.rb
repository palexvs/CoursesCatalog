class AddCreatedByAndPublishStatusToStartDates < ActiveRecord::Migration
  def change

    add_column :start_dates, :created_by, :integer, :null => false, :default => 0
    change_column_default(:start_dates, :created_by, nil)
    
    add_column :start_dates, :publish_status, :string, :null => false, :default => ""
    change_column_default(:start_dates, :publish_status, nil)

    add_index :start_dates, :created_by
    add_index :start_dates, [:created_by, :publish_status]   

  end
end
