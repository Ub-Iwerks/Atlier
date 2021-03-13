require 'rails_helper'

RSpec.describe "Works", type: :request do
  let(:base_title) { 'Atlier' }

  describe "POST /works" do
    let(:user) { create(:user) }
    let(:title) { "TITLE" }
    let(:concept) { "This is concept text" }
    context "user who not sign_in" do
      before do
        post works_path, params: {
          work: {
            title: title,
            concept: concept,
            user_id: user.id,
          },
        }
      end

      it "redirect to sign_in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user who sign_in" do
      before do
        sign_in user
        post works_path, params: {
          work: {
            title: title,
            concept: concept,
            user_id: user.id,
          },
        }
      end

      it "create success" do
        expect(response.status).to eq 302
      end
    end
  end

  describe "DELETE /works/id" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let!(:work) { create(:work, user: user) }
    let!(:count) { Work.count }

    context "user who not sign_in" do
      before do
        delete work_path work
      end

      it "redirect to sign_in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "another user" do
      before do
        sign_in another_user
        delete work_path work
      end

      it "redirect to home page" do
        expect(response).to redirect_to root_path
      end
    end

    context "correct user who sign_in" do
      before do
        sign_in user
        delete work_path work
      end

      it "delete success" do
        expect(response.status).to eq 302
      end

      it "delete by work model" do
        expect(Work.count).to eq count - 1
      end
    end
  end
end
