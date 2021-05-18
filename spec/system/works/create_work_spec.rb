require "rails_helper"

RSpec.describe "Create or delete work", type: :system, js: true do
  let(:user) { create(:user) }

  context "create work" do
    before do
      sign_in user
      visit root_path
      within("li.dropdown") do
        click_on "#{user.username}"
      end
      click_link "新規作品"
    end

    let!(:parent_category) { create(:category, name: "child_category", ancestry: nil) }
    let!(:child_category) { create(:category, name: "parent_category", ancestry: parent_category.id) }
    let(:title) { "This is title" }
    let(:concept) { "This is concept" }
    let(:description) { "This is description" }
    let(:illustration_name) { "This is illustration_name" }
    let(:illustration_description) { "This is illustration_description" }
    let(:image_path) { File.join(Rails.root, "spec/fixture/files/test.jpeg") }
    it "created successfully" do
      within(".form--create_work") do
        fill_in "作品タイトル", with: title
        find("option[value='#{parent_category.id}']").select_option
        within(".category__child") do
          find("option[value='#{child_category.id}']").select_option
        end
        attach_file('work_create[image]', image_path, make_visible: true)
        expect(page).to have_selector "img[alt='preview']"
        fill_in "コンセプト", with: concept
        fill_in "作品説明", with: description
        fill_in "work_create_illustrations_attributes_0_name", with: illustration_name
        fill_in "work_create_illustrations_attributes_0_description", with: illustration_description
        attach_file('work_create[illustrations_attributes][0][photo]', image_path, make_visible: true)
        click_button "登録する"
      end
      expect(page).to have_selector "p.success"
      expect(page).to have_title "#{title} - Atlier"
      within(".work--main_info") do
        expect(page).to have_selector "h3", text: "#{title}"
        expect(page).to have_selector "img[src$='test.jpeg']"
        expect(page).to have_selector "p", text: "#{concept}"
        expect(page).to have_selector "p", text: "#{description}"
      end
      within("li.illustration--info") do
        expect(page).to have_selector "img[src$='test.jpeg']"
        expect(page).to have_selector "span.name", text: "#{illustration_name}"
        expect(page).to have_selector "span.description", text: "#{illustration_description}"
      end
      visit current_path
      expect(page).not_to have_selector "p.success"
    end

    it "created in failure because category isn't selected" do
      within(".form--create_work") do
        fill_in "作品タイトル", with: title
        fill_in "コンセプト", with: concept
        attach_file('work_create[image]', image_path, make_visible: true)
        expect(page).to have_selector "img[alt='preview']"
        click_button "登録する"
      end
      within(".error_explanation") do
        expect(all('li').size).to eq(1)
        expect(page).to have_selector "li", text: "カテゴリーを入力してください"
      end
    end

    it "created in failure because a image isn't attached" do
      within(".form--create_work") do
        fill_in "作品タイトル", with: title
        fill_in "コンセプト", with: concept
        find("option[value='#{parent_category.id}']").select_option
        within(".category__child") do
          find("option[value='#{child_category.id}']").select_option
        end
        click_button "登録する"
      end
      within(".error_explanation") do
        expect(all('li').size).to eq(1)
        expect(page).to have_selector "li", text: "メイン画像ファイルを添付してください。"
      end
    end
  end

  context "delete work" do
    let(:work) { create(:work, user_id: user.id) }
    it "deleted successfully" do
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
end
