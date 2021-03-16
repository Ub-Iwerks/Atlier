require 'rails_helper'

RSpec.describe 'User edit imformation', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:changed_name) { "changed_name" }
  let(:changed_website) { "https://example/example" }
  let(:changed_description) { "changed_description" }

  it "change user imformation success" do
    sign_in user
    visit root_path
    click_link "アカウント編集"
    expect(page).to have_selector "h2", text: "プロフィールを編集"
    within("#edit_user") do
      fill_in "ユーザーネーム", with: changed_name
      fill_in "ウェブサイト", with: changed_website
      fill_in "自己紹介", with: changed_description
      fill_in "Eメール", with: user.email
      click_button "変更を保存する"
    end
    expect(current_path).to eq user_path(user)
    within(".user_info") do
      expect(page).to have_selector "h1", text: changed_name
      expect(page).to have_link text: changed_website
      expect(page).to have_selector "li.description", text: changed_description
    end
    expect(page).to have_selector ".notice", text: "アカウント情報を変更しました"
    visit current_path
    expect(page).not_to have_selector ".notice"
  end
end
