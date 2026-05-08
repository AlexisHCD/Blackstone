class CourseEpisode < ApplicationRecord
  belongs_to :course

  validates :title, presence: true
  validates :youtube_url, presence: true

  before_save :extract_youtube_id

  private

  def extract_youtube_id
    return if youtube_url.blank?

    # Soporta formatos:
    # https://www.youtube.com/watch?v=XXXXX
    # https://youtu.be/XXXXX
    # https://www.youtube.com/embed/XXXXX
    if youtube_url.include?("youtu.be/")
      self.youtube_id = youtube_url.split("youtu.be/").last.split(/[?&]/).first
    elsif youtube_url.include?("watch?v=")
      self.youtube_id = youtube_url.split("watch?v=").last.split(/[?&]/).first
    elsif youtube_url.include?("/embed/")
      self.youtube_id = youtube_url.split("/embed/").last.split(/[?&]/).first
    end
  end
end
