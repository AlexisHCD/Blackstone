class Category < ApplicationRecord
  has_many :tools

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end