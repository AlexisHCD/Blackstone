class FavoriteTool < ApplicationRecord
  belongs_to :user
  belongs_to :tool

  validates :tool_id, uniqueness: { scope: :user_id, message: "ya está en tus favoritos" }
end
