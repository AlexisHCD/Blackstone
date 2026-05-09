class FavoriteCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :course_id, uniqueness: { scope: :user_id, message: "ya está en tus favoritos" }
end
