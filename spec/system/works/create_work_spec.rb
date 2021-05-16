require "rails_helper"

RSpec.describe "Create or delete work", type: :system, js: true do
  let(:user) { create(:user) }
  let(:work) { create(:work, user_id: user.id) }

  it "delete work" do
    sign_in user
    visit work_path work
    within(".work--settings") do
      expect(page).to have_selector "span.delete_btn"
      page.accept_confirm do
        click_link "削除する"
      end
    end
  end
end
