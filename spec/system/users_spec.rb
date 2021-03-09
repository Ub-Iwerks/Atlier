require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "Signup test" do
    subject { User.find_by(email: email) }

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
          fill_in "Eメール", with: email
          fill_in "パスワード", with: password
          fill_in "パスワード（確認用）", with: password
          click_button "新規登録"
        end
        is_expected.to be_truthy
        expect(page).to have_selector ".notice", text: "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
        visit current_path
        expect(page).not_to have_selector ".notice"
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
          fill_in "Eメール", with: email
          fill_in "パスワード", with: password
          fill_in "パスワード（確認用）", with: password
          click_button "新規登録"
        end
        is_expected.to be_falsey
        within("form") do
          expect(page).to have_selector "#error_explanation"
          expect(page).to have_selector "div.field_with_errors"
        end
      end
    end
  end

  describe "Signin test" do
    let!(:user) { create(:user) }

    context "user has valid signin imformation" do
      it "signin success" do
        visit root_path
        click_link "ログイン"
        expect(page).to have_selector "h2", text: "ログイン"
        within("form") do
          fill_in "Eメール", with: user.email
          fill_in "パスワード", with: user.password
          click_button "ログイン"
        end
        expect(current_path).to eq root_path
        expect(page).to have_selector ".notice", text: "ログインしました。"
        visit current_path
        expect(page).not_to have_selector ".notice"
      end
    end

    context "user has invalid signin imformation" do
      let(:invalid_password) { "abcd1234" }
      it "signin false" do
        visit root_path
        click_link "ログイン"
        expect(page).to have_selector "h2", text: "ログイン"
        within("form") do
          fill_in "Eメール", with: user.email
          fill_in "パスワード", with: invalid_password
          click_button "ログイン"
        end
        expect(current_path).to eq new_user_session_path
        expect(page).to have_selector ".alert", text: "Eメールまたはパスワードが違います。"
        visit current_path
        expect(page).not_to have_selector ".alert"
      end
    end
  end

  describe "Edit user imformation test" do
    let(:user) { create(:user) }
    let(:changed_name) { "changed_name" }
    it "change user imformation success" do
      sign_in user
      visit root_path
      click_link "アカウント編集"
      expect(page).to have_selector "h2", text: "プロフィールを編集"
      within("#edit_user") do
        fill_in "ユーザーネーム", with: changed_name
        fill_in "Eメール", with: user.email
        click_button "変更を保存する"
      end
      expect(current_path).to eq user_path(user)
      expect(page).to have_selector "h1", text: changed_name
      expect(page).to have_selector ".notice", text: "アカウント情報を変更しました"
      visit current_path
      expect(page).not_to have_selector ".notice"
    end
  end
end
