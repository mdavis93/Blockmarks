class Bookmark < ApplicationRecord
  include HTTParty

  belongs_to :topic
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :url, presence: true, uniqueness: { case_sensitive: false }
  validates :user, presence: true
  validate :valid_url

  def valid_url
    # Check if the URL is valid by making a GET request, and checking for HTTPSuccess
    request = HTTParty.get(url) rescue nil

    errors.add(:url, 'Error Fetching URL') if request.nil?

    unless request.nil?
      if request.success?
        bookmark_title(request)
      else
        populate_errors(request)
      end
    end
  end

  def display_name
    name.truncate(25, omission: '...')
  end

  private

  def populate_errors(request)
    errors.add(:url, 'Page Not Found') if request.not_found?
    errors.add(:url, 'Access Forbidden') if request.forbidden?
    errors.add(:url, 'Server Error') if request.code > 499
  end

  def bookmark_title(resp)
    self.name = %r{<title>(.*?)</title>}.match(resp.body)[1]
  end
end
