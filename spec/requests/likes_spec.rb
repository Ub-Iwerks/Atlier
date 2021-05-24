require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:work) { create(:work) }
  describe "GET /users/:user_id/likes" do
    let(:page_title) { "いいねした作品" }
    context "user dosent sign in" do
      before { get user_likes_path user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        get user_likes_path user
      end

      it "render favorites" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{page_title} | #{user.username}<\/title>/i)
      end
    end
  end

  describe "POST /works/:work_id/likes" do
    context "user dosent sign in" do
      before { post work_likes_path work }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        post work_likes_path work
      end

      it "likes work correctly" do
        expect(response.status).to eq 302
      end
    end
  end

  describe "DELETE /works/:work_id/likes/:id" do
    let(:like) { create(:like, user_id: user.id, work_id: work.id) }
    context "user dosent sign in" do
      before { delete work_like_path(work, like) }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        delete work_like_path(work, like)
      end

      it "delete like correctly" do
        expect(response.status).to eq 302
      end
    end
  end
end
