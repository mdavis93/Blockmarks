class Bookmark < ApplicationRecord
  include HTTParty

  belongs_to :topic

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validate :valid_url


  def valid_url

    # Check if the URL is valid by making a GET request, and checking for HTTPSuccess
    request = HTTParty.get(url) rescue nil

    if request.nil?
      self.errors.add(:url, "Error Fetching URL") if request.nil?
    else
      self.errors.add(:url, "Page Not Found") if request.not_found?
      self.errors.add(:url, "Access Forbidden") if request.forbidden?
      self.errors.add(:url, "Server Error") if code > 499
    end
  end
end
