class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :video_progresses, dependent: :destroy
  has_many :favorite_tools, dependent: :destroy
  has_many :favorited_tools, through: :favorite_tools, source: :tool
  has_many :favorite_courses, dependent: :destroy
  has_many :favorited_courses, through: :favorite_courses, source: :course

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    user.email      = auth.info.email
    user.name     ||= auth.info.name
    user.password   = Devise.friendly_token[0, 20] if user.new_record?

    user.save!
    user
  end
end
