class VideoProgress < ApplicationRecord
  belongs_to :user
  belongs_to :course_episode

  validates :course_episode_id, uniqueness: { scope: :user_id }
  validates :seconds_watched, numericality: { greater_than_or_equal_to: 0 }
end
