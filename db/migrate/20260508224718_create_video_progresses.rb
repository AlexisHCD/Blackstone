class CreateVideoProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :video_progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_episode, null: false, foreign_key: true
      t.integer :seconds_watched, default: 0
      t.boolean :completed, default: false

      t.timestamps
    end

    add_index :video_progresses, [:user_id, :course_episode_id], unique: true
  end
end
