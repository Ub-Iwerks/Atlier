require "rails_helper"

RSpec.describe "Stocked work", type: :system do
  let(:user) { create(:user) }
  let(:works_user) { create(:user) }
  let(:first_work) { create(:work, user: works_user) }
  let(:second_work) { create(:work, user: works_user) }

  before do
    Stock.create(user: user, work: first_work)
    Stock.create(user: user, work: second_work)
  end

  it "display stocked works" do
    sign_in user
    visit stocks_user_path(user)
    within(".user--works__stocks") do
      expect(all('.work--card').size).to eq(2)
    end
    visit stocks_user_path(works_user)
    within(".user--works__stocks") do
      expect(page).to have_selector "h4", text: "保存した作品がありません"
    end
  end

end
