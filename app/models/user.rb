class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :video_progresses, dependent: :destroy
  has_many :favorite_tools, dependent: :destroy
  has_many :favorited_tools, through: :favorite_tools, source: :tool
  has_many :favorite_courses, dependent: :destroy
  has_many :favorited_courses, through: :favorite_courses, source: :course
end
