require 'rails_helper'

RSpec.describe Footprint, type: :model do
  describe "Validations test" do
    subject { footprint }

    context "footprint has valid information" do
      let(:footprint) { build(:footprint) }
      it { is_expected.to be_valid }
    end

    context "footprint doesn't associated with a user" do
      let(:footprint) { build(:footprint, user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "footprint doesn't associated with a work" do
      let(:footprint) { build(:footprint, work: nil) }
      it { is_expected.not_to be_valid }
    end

    context "counts of footprint is nil" do
      let(:footprint) { build(:footprint, counts: nil) }
      it { is_expected.not_to be_valid }
    end

    context "footprint has duplicate association" do
      let(:user) { create(:user) }
      let(:work) { create(:work) }
      let!(:first_footprint) { create(:footprint, user: user, work: work) }
      let(:footprint) { build(:footprint, user: user, work: work) }
      it { is_expected.not_to be_valid }
    end
  end

  describe "Default value's test" do
    let(:footprint) { create(:footprint) }

    it "value of counts is 1" do
      expect(footprint.counts).to eq 1
    end
  end
end
