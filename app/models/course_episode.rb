class CourseEpisode < ApplicationRecord
  belongs_to :course
  has_many :video_progresses, dependent: :destroy

  validates :title, presence: true
  validates :youtube_url, presence: true

  before_save :extract_youtube_id

  def duration_minutes
    (duration_seconds.to_f / 60).round
  end

  def duration_minutes=(val)
    self.duration_seconds = val.to_i * 60
  end

  private

  def extract_youtube_id
    return if youtube_url.blank?

    if youtube_url.include?("youtu.be/")
      self.youtube_id = youtube_url.split("youtu.be/").last.split(/[?&]/).first
    elsif youtube_url.include?("watch?v=")
      self.youtube_id = youtube_url.split("watch?v=").last.split(/[?&]/).first
    elsif youtube_url.include?("/embed/")
      self.youtube_id = youtube_url.split("/embed/").last.split(/[?&]/).first
    end
  end
end
