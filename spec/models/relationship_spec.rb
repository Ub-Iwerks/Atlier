require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe "Validation test" do
    subject { relationship }

    let!(:user) { create(:user) }
    let!(:another_user) { create(:user) }

    context "relationships has valid imformation" do
      let(:relationship) { build(:relationship, follower_id: user.id, followed_id: another_user.id) }
      it { is_expected.to be_valid }
    end

    context "relationships dont have follower imformation" do
      let(:relationship) { build(:relationship, follower_id: nil, followed_id: another_user.id) }
      it { is_expected.not_to be_valid }
    end

    context "relationships dont have followed imformation" do
      let(:relationship) { build(:relationship, follower_id: user.id, followed_id: nil) }
      it { is_expected.not_to be_valid }
    end
  end
end
