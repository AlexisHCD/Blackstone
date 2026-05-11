class Course < ApplicationRecord
  belongs_to :category
  has_many :course_episodes, -> { order(:position) }, dependent: :destroy
  has_many :favorite_courses, dependent: :destroy

  before_validation :generate_slug

  validates :title, presence: true
  validates :is_series, inclusion: { in: [true, false] }
  validates :slug, presence: true, uniqueness: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.parameterize if title.present?
  end
end
