class Bookmark < ApplicationRecord
  include HTTParty

  belongs_to :topic
  belongs_to :user
  # before_save :valid_url

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
  validate :valid_url

  def valid_url
    puts "\nValidating URL\n"

    # Check if the URL is valid by making a GET request, and checking for HTTPSuccess
    request = HTTParty.get(url) rescue nil

    errors.add(:url, 'Error Fetching URL') if request.nil?

    populate_errors(request) unless request.nil? || request.success?
  end

  def populate_errors(request)
    errors.add(:url, 'Page Not Found') if request.not_found?
    errors.add(:url, 'Access Forbidden') if request.forbidden?
    errors.add(:url, 'Server Error') if request.code > 499
  end
end
