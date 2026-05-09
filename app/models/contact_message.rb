class ContactMessage < ApplicationRecord
  MESSAGE_TYPES = ["sugerencia", "reclamo", "link_roto", "otro"]

  belongs_to :tool, optional: true

  validates :name, presence: true
  validates :email, presence: true
  validates :message_type, presence: true, inclusion: { in: MESSAGE_TYPES }
  validates :body, presence: true
end
