class Bookmark < ApplicationRecord
  belongs_to :topic

  validates :url, presence: true, uniqueness: { case_sensitive: false }
end
