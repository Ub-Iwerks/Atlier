require 'rails_helper'

RSpec.describe Work, type: :model do
  describe "Validations test" do
    subject { work }

    let(:user) { create(:user) }
    let(:work) { build(:work, user: user) }

    context "work has valid imformatioin" do
      it { is_expected.to be_valid }
    end

    context "work doesnt have association to user" do
      let(:work) { build(:work, user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "work doesnt have title" do
      let(:title) { " " * 50 }
      let(:work) { build(:work, title: title) }
      it { is_expected.not_to be_valid }
    end

    context "work has too long title" do
      let(:title) { "a" * 51 }
      let(:work) { build(:work, title: title) }
      it { is_expected.not_to be_valid }
    end

    context "work has too long concept" do
      let(:concept) { "a" * 301 }
      let(:work) { build(:work, concept: concept) }
      it { is_expected.not_to be_valid }
    end

    context "works array" do
      let(:now) { Time.current }
      let(:yesterday) { 1.day.ago }
      let(:one_week_ago) { 1.week.ago }
      let(:user) { create(:user) }
      let!(:one_week_ago_work) { create(:work, created_at: one_week_ago, user: user) }
      let!(:yesterday_work) { create(:work, created_at: yesterday, user: user) }
      let!(:now_work) { create(:work, created_at: now, user: user) }
      it "line up more recnt" do
        expect(user.works).to eq [now_work, yesterday_work, one_week_ago_work]
      end
    end
  end
end
