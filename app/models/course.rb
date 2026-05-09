class Course < ApplicationRecord
  belongs_to :category
  has_many :course_episodes, -> { order(:position) }, dependent: :destroy
  has_many :favorite_courses, dependent: :destroy

  validates :title, presence: true
  validates :is_series, inclusion: { in: [true, false] }
end
