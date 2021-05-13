require 'rails_helper'

RSpec.describe 'User signin', type: :system do
  let!(:user) { create(:user) }

  context "user has valid signin imformation" do
    it "signin success" do
      visit root_path
      within(".home--msg") do
        click_link "ログイン"
      end
      expect(page).to have_selector "h2", text: "ログイン"
      within("form.form--common") do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
      end
      expect(current_path).to eq root_path
      expect(page).to have_selector ".success", text: "ログインしました。"
      visit current_path
      expect(page).not_to have_selector ".success"
    end
  end

  context "user has invalid signin imformation" do
    let(:invalid_password) { "abcd1234" }
    it "signin false" do
      visit root_path
      within(".home--msg") do
        click_link "ログイン"
      end
      expect(page).to have_selector "h2", text: "ログイン"
      within("form.form--common") do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: invalid_password
        click_button "ログイン"
      end
      expect(current_path).to eq new_user_session_path
      expect(page).to have_selector ".danger", text: "メールアドレスまたはパスワードが違います。"
      visit current_path
      expect(page).not_to have_selector ".danger"
    end
  end
end
