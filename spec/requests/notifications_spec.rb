require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let(:base_title) { 'Atlier' }

  describe "GET /notifications" do
    let(:title) { '通知' }
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let!(:notification) { create(:notification, visitor: another_user, visited: user, action: "like") }

    context "user not signed in" do
      before { get notifications_path }

      it "redirect_to sign in page" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        get notifications_path
      end

      it "render index" do
        expect(response.status).to eq 200
      end

      it "has page title correctly" do
        expect(response.body).to match(/<title>#{title} | #{base_title}<\/title>/i)
      end
    end
  end
end
