class CreateStartDates < ActiveRecord::Migration
  def change
    create_table :start_dates do |t|
      t.references :course, null: false
      t.date :start_on, null: false

      t.timestamps
    end
    add_index :start_dates, :course_id
    add_index :start_dates, [:course_id, :start_on], unique: true
  end
end
