class CreateCourseEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :course_episodes do |t|
      t.string :title
      t.string :youtube_url
      t.string :youtube_id
      t.integer :duration_seconds
      t.integer :position
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
