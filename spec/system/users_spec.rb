require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "user signup test" do
    let!(:user) { build(:user)}
    subject { User.find_by(email: email) }

    context "user has valid imformation" do
      let(:name) { "test_user" }
      let(:email) { "test@example.com" }
      let(:password) { "password" }
      it "signup success" do
        visit root_path
        click_link "新規登録する"
        expect(page).to have_selector "h2", text: "新規登録"
        within("form") do
          fill_in "ユーザーネーム", with: name
          fill_in "Eメール", with: email
          fill_in "パスワード", with: password
          fill_in "パスワード（確認用）", with: password
          click_button "新規登録"
        end
        is_expected.to be_truthy
        expect(page).to have_selector ".flash-success", text: "Atrierへようこそ！！！"
        expect(page).to have_selector "h1", text: name
        expect(page).to have_selector "p", text: email
        visit current_path
        expect(page).to_not have_selector ".flash-success"
      end
    end

    context "user has invalid imformation" do
      let(:name) { " " }
      let(:email) { "test@example" }
      let(:password) { "password" }
      it "signup false" do
        visit root_path
        click_link "新規登録する"
        expect(page).to have_selector "h2", text: "新規登録"
        within("form") do
          fill_in "ユーザーネーム", with: name
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
end
