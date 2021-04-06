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

  context "user signed in" do
    it "check layouts has the number of links correctly" do
      sign_in user
      visit root_path
      within("header") do
        expect(page).to have_link "Atlier", href: root_path
        expect(page).to have_link href: root_path, class: "fa-th-large"
        expect(page).to have_link href: users_path, class: "fa-list-ul"
        expect(page).to have_link href: notifications_path
        expect(page).to have_selector "i.fa-bell"
        expect(page).to have_link href: search_works_path, class: "fa-search"
        expect(page).to have_link "ログアウト", href: destroy_user_session_path
        expect(page).to have_link "プロフィール", href: user_path(user)
        expect(page).to have_link "アカウント編集", href: edit_user_registration_path
        expect(page).to have_link "新規作品", href: new_work_path
      end
      within("footer") do
        expect(page).to have_link "お問い合わせ", href: contact_path
        expect(page).to have_link "利用規約", href: terms_path
        expect(page).to have_link "Atlier", href: root_path
      end
    end
  end
end
