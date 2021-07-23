require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe "Validations test" do
    subject { stock }

    let(:user) { create(:user) }
    let(:work) { create(:work) }
    let(:other_work) { create(:work) }

    context "stock has valid information" do
      let(:stock) { build(:stock, user: user, work: work) }
      it { is_expected.to be_valid }
    end

    context "stock has valid information of different pair" do
      before { Stock.create(user: user, work: work) }

      let(:stock) { build(:stock, user: user, work: other_work) }
      it { is_expected.to be_valid }
    end

    context "stock doesnt have work information" do
      let(:stock) { build(:stock, user: user, work: nil) }
      it { is_expected.not_to be_valid }
    end

    context "stock doesnt have user information" do
      let(:stock) { build(:stock, user: nil, work: work) }
      it { is_expected.not_to be_valid }
    end

    context "stock has duplicate information" do
      before { Stock.create(user: user, work: work) }

      let(:stock) { build(:stock, user: user, work: work) }
      it { is_expected.not_to be_valid }
    end
  end
end
