require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "Validations test" do
    subject { comment }

    context "comment has valid imformation" do
      let(:comment) { build(:comment) }
      it { is_expected.to be_valid }
    end

    context "comment doesnt has work_id" do
      let(:comment) { build(:comment, work_id: nil) }
      it { is_expected.not_to be_valid }
    end

    context "comment doesnt has user_id" do
      let(:comment) { build(:comment, user_id: nil) }
      it { is_expected.not_to be_valid }
    end

    context "comment doesnt has its content" do
      let(:blank_content) { " " * 150 }
      let(:comment) { build(:comment, content: blank_content) }
      it { is_expected.not_to be_valid }
    end

    context "comment has too long content" do
      let(:long_content) { "a" * 151 }
      let(:comment) { build(:comment, content: long_content) }
      it { is_expected.not_to be_valid }
    end
  end
end
