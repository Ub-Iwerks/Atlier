require 'rails_helper'

RSpec.describe "Works", type: :request do
  describe "POST /works/:work_id/comments" do
    let(:user) { create(:user) }
    let(:work) { create(:work) }
    let(:comment_params) { attributes_for(:comment, user: user, work: work) }
    context "user doesnt sign in" do
      before do
        post comments_path, params: {
          comment: comment_params,
        }
      end

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      let(:user) { create(:user) }
      let(:work) { create(:work) }
      let(:content) { "This is good" }
      before do
        sign_in user
        post comments_path, params: {
          comment: {
            content: content,
            work_id: work.id,
          },
        }
      end

      it "create success" do
        expect(response.status).to eq 302
      end
    end
  end

  describe "DELETE /works/:work_id/comments/id" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:work) { create(:work) }
    let!(:comment) { create(:comment, user: user, work: work) }

    context "user doesnt sign in" do
      before { delete comment_path comment }

      it "redirect to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "another user" do
      before do
        sign_in another_user
        delete comment_path comment
      end

      it "redirect to home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "correct user sign in" do
      let!(:count) { Comment.count }
      before do
        sign_in user
        delete comment_path comment
      end

      it "delete success" do
        expect(response.status).to eq 302
      end

      it "is deleted by comment model" do
        expect(Comment.count).to eq count - 1
      end
    end
  end
end
