class Bookmark < ApplicationRecord
  include HTTParty

  belongs_to :topic
  belongs_to :user
  before_save :valid_url

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true

  def valid_url

    # Check if the URL is valid by making a GET request, and checking for HTTPSuccess
    begin
      request = HTTParty.get(url)
    rescue HTTParty::Error
      nil
    end

    if request.nil?
      errors.add(:url, 'Error Fetching URL') if request.nil?
    end

    if errors.any?
      populate_errors
      throw :abort
    end
  end

  def populate_errors
    errors.add(:url, 'Page Not Found') if request.not_found?
    errors.add(:url, 'Access Forbidden') if request.forbidden?
    errors.add(:url, 'Server Error') if request.code > 499
  end
end
