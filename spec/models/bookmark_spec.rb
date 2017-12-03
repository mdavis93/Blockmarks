require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let(:user) { create(:user, email: 'test@blocmarks.com', password: 'helloworld') }
  let(:topic) { create(:topic, user: user) }
  let(:bookmark) { create(:bookmark, topic: topic) }

  it { is_expected.to belong_to(:topic)}

  describe "attributes" do
    it "has url attribute" do
      expect(bookmark).to have_attributes(url: bookmark.url)
    end
  end
end
