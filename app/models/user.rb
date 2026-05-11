class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:google_oauth2, :microsoft_graph]

  has_many :video_progresses, dependent: :destroy
  has_many :favorite_tools, dependent: :destroy
  has_many :favorited_tools, through: :favorite_tools, source: :tool
  has_many :favorite_courses, dependent: :destroy
  has_many :favorited_courses, through: :favorite_courses, source: :course

  def self.from_omniauth(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)

    unless user
      user = find_by(email: auth.info.email)

      if user
        user.update!(provider: auth.provider, uid: auth.uid)
      else
        user = new(
          email:    auth.info.email,
          name:     auth.info.name,
          provider: auth.provider,
          uid:      auth.uid,
          password: Devise.friendly_token[0, 20]
        )
        user.save!
      end
    end

    user.name ||= auth.info.name if auth.info.name.present?
    user
  end
end
