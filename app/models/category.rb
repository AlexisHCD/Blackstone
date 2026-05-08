class Category < ApplicationRecord
  has_many :tools, dependent: :destroy
  has_many :courses, dependent: :destroy

  before_validation :generate_slug

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  private

  def generate_slug
    self.slug = name.parameterize if name.present?
  end
end