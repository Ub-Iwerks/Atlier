require 'rails_helper'

RSpec.describe 'Works interface', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:works) { create_list(:work, 21, user: user) }
  let!(:another_works) { create_list(:work, 21, user: another_user) }
  let(:title) { "Sky is limit" }
  let(:no_title) { " " }
  let(:concept) { "This is the concept" }
  let(:current_work) { Work.find_by(title: title) }

  it "check layouts has the number of links correctly" do
    sign_in user
    visit root_path
    within(".pagination") do
      expect(page).to have_link href: '/?page=2'
    end
    within(".work_form") do
      fill_in "タイトル", with: no_title
      click_button "投稿する"
    end
    within("aside") do
      expect(page).to have_selector "#error_explanation"
      expect(page).to have_selector "div.field_with_errors"
    end
    within(".work_form") do
      fill_in "タイトル", with: title
      fill_in "コンセプト", with: concept
      click_button "投稿する"
    end
    expect(current_path).to eq root_path
    expect(page).to have_selector ".success", text: "投稿しました！"
    visit current_path
    within("li#work-#{current_work.id}") do
      expect(page).to have_selector "span.title", text: "#{title}"
      expect(page).to have_selector "span.concept", text: "#{concept}"
    end
    within("li#work-#{current_work.id}") do
      click_link "削除"
    end
    expect(page).not_to have_selector "li#work-#{current_work.id}"
    visit user_path(another_user)
    within(".works") do
      expect(page).not_to have_link "削除"
    end
  end
end
