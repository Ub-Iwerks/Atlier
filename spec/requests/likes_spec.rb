require 'rails_helper'

RSpec.describe "Likes", type: :request do
  let!(:user) { create(:user) }
  let!(:work) { create(:work) }

  describe "POST /works/:work_id/likes" do
    context "user dosent sign in" do
      before do
        post work_likes_path work
      end

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
      before do
        delete work_like_path(work, like)
      end

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
