require 'rails_helper'

RSpec.describe 'Layouts', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  context "user dont sign in" do
    it "check layouts has the number of links correctly" do
      visit root_path
      within("header") do
        expect(page).to have_link "Atlier", href: root_path
        expect(page).to have_link "ホーム", href: root_path
        expect(page).to have_link "ログイン", href: new_user_session_path
      end
      within("footer") do
        expect(page).to have_link "お問い合わせ", href: contact_path
        expect(page).to have_link "利用規約", href: terms_path
        expect(page).to have_link "Atlier", href: root_path
      end
    end
  end

  context "user sign in" do
    it "check layouts has the number of links correctly" do
      sign_in user
      visit root_path
      within("header") do
        expect(page).to have_link "Atlier", href: root_path
        expect(page).to have_link "ホーム", href: root_path
        expect(page).to have_link "ログアウト", href: destroy_user_session_path
        expect(page).to have_link "プロフィール", href: user_path(user)
      end
      within("footer") do
        expect(page).to have_link "お問い合わせ", href: contact_path
        expect(page).to have_link "利用規約", href: terms_path
        expect(page).to have_link "Atlier", href: root_path
      end
    end
  end
end
