require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
  let(:my_user) { create(:user, email: 'test@blocmarks.com', password: 'helloworld') }
  let(:my_topic) { create(:topic, title: "Testing Bookmark", user: my_user) }

  context 'with params hash' do
    let(:my_bookmark) { create(:bookmark, topic: my_topic) }
    let!(:params_hash) { {params: { topic_id: my_topic.id, id: my_bookmark.id }} }

    describe "GET #show" do
      it "returns http success" do
        get :show, params_hash
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params_hash
        expect(response).to render_template :show
      end

      it "assigns my_bookmark to @bookmark" do
        get :show, params_hash
        expect(assigns(:bookmark)).to eq(my_bookmark)
      end
    end

=begin
TODO: Fix EDIT tests
=end
    describe "GET #edit" do
      before :each do
        sign_in my_user
        my_user.admin!
      end

      it "returns http success" do
        get :edit, params_hash
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params_hash
        expect(response).to render_template :edit
      end

      it "assigns bookmark to be updated to @bookmark" do
        get :edit, params_hash
        bookmark_instance = assigns(:bookmark)

        expect(bookmark_instance.id).to eq my_bookmark.id
        expect(bookmark_instance.url).to eq my_bookmark.url
        expect(bookmark_instance.topic).to eq my_bookmark.topic
      end
    end

    describe "PUT #update" do
      it "updates bookmark with expected attributes" do
        new_url = "www.bloc.io"

        put :update, params: { topic_id: my_topic.id, id: my_bookmark.id, bookmark: { url: new_url } }

        updated_bookmark = assigns(:bookmark)
        expect(updated_bookmark.id).to eq my_bookmark.id
        expect(updated_bookmark.url).to eq new_url
        expect(updated_bookmark.topic).to eq my_bookmark.topic
      end

      it "redirects to the updated bookmark" do
        new_url = "www.bloc.io"

        put :update, params: { topic_id: my_topic.id, id: my_bookmark.id, bookmark: { url: new_url } }
        expect(response).to redirect_to [my_topic, my_bookmark]
      end
    end

    describe "DELETE destroy" do
      it "deletes the bookmark" do
        delete :destroy, params_hash
        count = Bookmark.where({id: my_bookmark.id}).size
        expect(count).to eq 0
      end

      it "redirects to bookmarks index" do
        delete :destroy, params_hash
        expect(response).to redirect_to my_topic
      end
    end
  end

  context "without params hash" do
=begin
TODO: Fix NEW tests
=end
    describe "GET #new" do
      it "returns http success" do
        get :new, params: { topic_id: my_topic.id }
        expect(response).to have_http_status(:success)
      end


      it "renders the #new view" do
        get :new, params: { topic_id: my_topic.id }
        expect(response).to render_template :new
      end

      it "instantiates @bookmark" do
        get :new, params: { topic_id: my_topic.id }
        expect(assigns(:bookmark)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increases the number of bookmarks by 1" do
          expect{ post :create, params: { topic_id: my_topic.id, bookmark: { url: "www.google.com" } } }.to change(Bookmark,:count).by(1)
      end

      it "assigns the new bookmark to @bookmark" do
        post :create, params: { topic_id: my_topic.id, bookmark: { url: "www.google.com" } }
        expect(assigns(:bookmark)).to eq Bookmark.last
      end

      it "redirects to the new bookmark" do
        post :create, params: { topic_id: my_topic.id, bookmark: { url: "www.google.com" } }
        expect(response).to redirect_to [my_topic, Bookmark.last]
      end
    end
  end
end
