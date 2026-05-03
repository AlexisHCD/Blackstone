class FeaturedItem < ApplicationRecord
  belongs_to :tool

  validates :featured_on, presence: true
  validates :featured_on, uniqueness: { scope: :tool_id, message: "Esta herramienta ya fue destacada en esta fecha" }
end
