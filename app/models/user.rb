class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :lockable

  has_many :topics
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy

  before_save { self.role ||= :member }

  enum role: [:member, :admin]

  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
