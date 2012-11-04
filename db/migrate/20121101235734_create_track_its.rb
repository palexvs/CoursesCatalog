class CreateTrackIts < ActiveRecord::Migration
  def change
    create_table :track_its do |t|
      t.references :user, null: false
      t.references :course, null: false

      t.timestamps
    end
    add_index :track_its, :user_id
    add_index :track_its, :course_id
    add_index :track_its, [:user_id, :course_id], :name => "index_users_on_user_and_course", :unique => true
  end
end
