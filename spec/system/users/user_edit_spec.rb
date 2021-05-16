require 'rails_helper'

RSpec.describe 'User edit imformation', type: :system, js: true do
  let(:user) { create(:user) }

  context "change user profile imformation" do
    let(:changed_name) { "changed_name" }
    let(:changed_website) { "https://example/example" }
    let(:changed_description) { "changed_description" }

    it "changed success" do
      sign_in user
      visit root_path
      within("li.dropdown") do
        expect(page).to have_link class: "dropdown-toggle"
        click_on "#{user.username}"
      end
      click_link "アカウント編集"
      expect(current_path).to eq edit_user_registration_path
      within("#edit_user") do
        fill_in "ユーザーネーム", with: changed_name
        fill_in "ウェブサイト", with: changed_website
        fill_in "自己紹介", with: changed_description
        fill_in "メールアドレス", with: user.email
        click_button "変更を保存する"
      end
      expect(current_path).to eq user_path(user)
      within(".user--info") do
        expect(page).to have_selector "h1", text: changed_name
        expect(page).to have_link text: changed_website
        expect(page).to have_selector "li.description", text: changed_description
      end
      expect(page).to have_selector ".success", text: "アカウント情報を変更しました"
      visit current_path
      expect(page).not_to have_selector ".success"
    end
  end

  context "change user password" do
    let(:current_password) { "#{user.password}" }
    let(:new_password) { "newpassword" }
    let(:wrong_password) { "wrongpassword" }

    it "changed success" do
      sign_in user
      visit root_path
      within("li.dropdown") do
        expect(page).to have_link class: "dropdown-toggle"
        click_on "#{user.username}"
      end
      click_link "アカウント編集"
      click_link "パスワードを変更する"
      expect(current_path).to eq edit_password_path
      within("#edit_user") do
        fill_in "現在のパスワード", with: current_password
        fill_in "新しいパスワード", with: new_password
        fill_in "新しいパスワード(確認)", with: new_password
        click_button "変更する"
      end
      expect(current_path).to eq edit_user_registration_path
      expect(page).to have_selector ".success", text: "パスワードを変更しました"
      visit current_path
      expect(page).not_to have_selector ".success"
    end

    it "changed false" do
      sign_in user
      visit root_path
      within("li.dropdown") do
        expect(page).to have_link class: "dropdown-toggle"
        click_on "#{user.username}"
      end
      click_link "アカウント編集"
      click_link "パスワードを変更する"
      expect(current_path).to eq edit_password_path
      within("#edit_user") do
        fill_in "現在のパスワード", with: wrong_password
        fill_in "新しいパスワード", with: new_password
        fill_in "新しいパスワード(確認)", with: new_password
        click_button "変更する"
      end
      expect(current_path).to eq edit_password_path
      expect(page).to have_selector ".error_explanation"
      visit current_path
      expect(page).not_to have_selector ".error_explanation"
    end
  end

  context "delete user account" do
    it "delete success" do
      sign_in user
      visit root_path
      within("li.dropdown") do
        expect(page).to have_link class: "dropdown-toggle"
        click_on "#{user.username}"
      end
      click_link "アカウント編集"
      within(".form--common") do
        page.accept_confirm do
          click_on "アカウントを削除する"
        end
      end
      expect(current_path).to eq root_path
      expect(page).to have_selector "p.success"
      visit current_path
      expect(page).not_to have_selector "p.success"
    end
  end
end
