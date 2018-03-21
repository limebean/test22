class AdminInfo < ApplicationRecord
  mount_uploader :document, DocumentUploader
  validates :name, presence: true
end
