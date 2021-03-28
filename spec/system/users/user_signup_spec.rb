require 'rails_helper'

RSpec.describe 'User signup', type: :system do
  subject { User.find_by(email: email) }

  before do
    driven_by(:rack_test)
  end

  let!(:user) { build(:user) }

  context "user has valid imformation" do
    let(:username) { "test_user" }
    let(:email) { "test@example.com" }
    let(:password) { "password" }
    it "signup success" do
      visit root_path
      click_link "新規登録する"
      expect(page).to have_selector "h2", text: "新規登録"
      within("form") do
        fill_in "ユーザーネーム", with: username
        fill_in "メールアドレス", with: email
        fill_in "パスワード", with: password
        fill_in "パスワード（確認用）", with: password
        click_button "新規登録"
      end
      is_expected.to be_truthy
      expect(page).to have_selector ".success", text: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      visit current_path
      expect(page).not_to have_selector ".success"
    end
  end

  context "user has invalid imformation" do
    let(:username) { " " }
    let(:email) { "test@example" }
    let(:password) { "password" }
    it "signup false" do
      visit root_path
      click_link "新規登録する"
      expect(page).to have_selector "h2", text: "新規登録"
      within("form") do
        fill_in "ユーザーネーム", with: username
        fill_in "メールアドレス", with: email
        fill_in "パスワード", with: password
        fill_in "パスワード（確認用）", with: password
        click_button "新規登録"
      end
      is_expected.to be_falsey
      within("form") do
        expect(page).to have_selector ".error_explanation"
        expect(page).to have_selector "div.field_with_errors"
      end
    end
  end
end
