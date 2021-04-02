require 'rails_helper'

RSpec.describe Illustration, type: :model do
  describe "Validation test" do
    subject { illustration }

    context "illustration has valid imformation" do
      let(:illustration) { build(:illustration) }
      it { is_expected.to be_valid }
    end

    context "illustration has too long name" do
      let(:name) { "a" * 51 }
      let(:illustration) { build(:illustration, name: name) }
      it { is_expected.not_to be_valid }
    end

    context "illustration has too long describe" do
      let(:description) { "a" * 151 }
      let(:illustration) { build(:illustration, description: description) }
      it { is_expected.not_to be_valid }
    end

    context "illustration doesnt have photo" do
      before { illustration.photo = nil }

      let(:illustration) { build(:illustration) }
      it { is_expected.not_to be_valid }
    end

    context "illustration attached same work" do
      let(:work) { create(:work) }
      let!(:illustration1) { create(:illustration, work: work) }
      let!(:illustration2) { create(:illustration, work: work) }
      it "has exactly position number 1" do
        expect(illustration1.position).to eq 1
      end

      it "has exactly position number 2" do
        expect(illustration2.position).to eq 2
      end
    end

    context "work has too many illustrations" do
      let(:work) { create(:work) }
      let!(:illustrations) { create_list(:illustration, 5, work: work) }
      let(:illustration) { build(:illustration, work: work) }
      it { is_expected.not_to be_valid }
    end
  end
end
