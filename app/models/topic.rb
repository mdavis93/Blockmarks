class Topic < ApplicationRecord
  belongs_to :user
  has_many :bookmarks

  def has_favorite(user)
    if user.nil?
      false
    else
      bookmarks.each do |bm|
        return true if bm.likes.count > 0
      end
    end
    false
  end

  def favorite_count(user)
    return 0 unless user
    bookmarks.map(&:likes).flatten.uniq.select do |like|
      like.user == user
    end.count
  end
end
