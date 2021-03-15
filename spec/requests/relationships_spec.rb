require 'rails_helper'

RSpec.describe "Relationships", type: :request do
  describe "POST /relationships" do
    let!(:user) { create(:user) }
    let!(:another_user) { create(:user) }

    context "user dosent sign in" do
      before do
        post relationships_path params: {
          relationship: {
            follower_id: user.id,
            followed_id: another_user.id,
          },
        }
      end

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE /relationships/:id" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context "user dosent sign in" do
      before { delete relationship_path another_user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
