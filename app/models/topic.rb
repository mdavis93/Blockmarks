class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks

  def has_favorite(user)
    if user.nil?
      false
    else
      bookmarks.each do |bm|
        return true if Like.where('bookmark_id = ?', bm.id).count > 0
      end
    end
    false
  end

  def favorite_count(user)
    count = 0
    unless user.nil?
      bookmarks.each do |bookmark|
        count += Like.where(
          'bookmark_id = ? AND user_id = ?',
          bookmark.id,
          user.id
        ).count
      end
    end
    count
  end
end
