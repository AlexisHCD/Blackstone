class Tool < ApplicationRecord
  has_one_attached :logo
  belongs_to :category, optional: false
  has_many :featured_items, dependent: :destroy

  before_validation :generate_slug

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :description, length: { maximum: 140 }

  private

  def generate_slug
    self.slug = name.parameterize if name.present?
  end
end