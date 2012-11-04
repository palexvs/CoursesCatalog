class AddStartByScheduleToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :start_by_schedule, :boolean, default: true
  end
end
