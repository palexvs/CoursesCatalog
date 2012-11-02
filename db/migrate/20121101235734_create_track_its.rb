class CreateTrackIts < ActiveRecord::Migration
  def change
    create_table :track_its do |t|
      t.references :user
      t.references :course

      t.timestamps
    end
    add_index :track_its, :user_id
    add_index :track_its, :course_id
  end
end
