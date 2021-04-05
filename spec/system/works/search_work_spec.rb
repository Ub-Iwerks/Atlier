require "rails_helper"

RSpec.describe "Search work", type: :system do
  before { driven_by(:rack_test) }

  let(:keyword) { "keyword" }
  let!(:work_with_title) { create(:work, title: keyword) }
  let!(:work_with_concept) { create(:work, concept: keyword) }

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
end
