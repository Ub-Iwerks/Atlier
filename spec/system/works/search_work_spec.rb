require "rails_helper"

RSpec.describe "Search work", type: :system, js: true do
  let(:keyword) { "keyword" }
  let!(:work_with_title) { create(:work, title: keyword) }
  let!(:work_with_concept) { create(:work, concept: keyword) }
  let!(:parent_category) { create(:category, name: "child_category", ancestry: nil) }
  let!(:child_category) { create(:category, name: "parent_category", ancestry: parent_category.id) }
  let!(:work_in_parent_category) { create(:work) }
  let!(:work_in_child_category) { create(:work) }

  context "search with keyword" do
    it "return works have keyword in title or concept" do
      visit search_works_path
      within(".form__search") do
        fill_in "キーワード", with: ""
        click_button "検索"
      end
      expect(page).to have_selector "h2", text: "検索結果に該当する作品がありません"
      within(".form__search") do
        fill_in "キーワード", with: keyword
        click_button "検索"
      end
      within("ol.works") do
        expect(page).to have_selector "li#work-#{work_with_title.id}"
        expect(page).to have_selector "li#work-#{work_with_concept.id}"
      end
    end
  end

  context "search with category" do
    before do
      work_in_parent_category.update(category_id: parent_category.id)
      work_in_child_category.update(category_id: child_category.id)
    end

    it "return works have correct category" do
      visit search_works_path
      within(".form__search") do
        within(".field--category") do
          expect(page).not_to have_selector "span.category__child"
          find("option[value='#{parent_category.id}']").select_option
          within("span.category__child") do
            find("option[value='#{child_category.id}']").select_option
          end
        end
        click_button "検索"
      end
      within("ol.works") do
        expect(page).not_to have_selector "li#work-#{work_in_parent_category.id}"
        expect(page).to have_selector "li#work-#{work_in_child_category.id}"
      end
    end
  end
end
