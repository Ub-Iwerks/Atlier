require "rails_helper"

RSpec.describe "Liked work", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:work) { create(:work, user: user) }
  let!(:like) { create(:like, user: another_user, work: work) }
  let!(:current_count) { work.likes.count }
  let(:liked) { Like.find_by(user_id: user.id, work_id: work.id) }

  it "display and create, destroy likes" do
    sign_in user
    visit work_path work
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_likes_path(work)
      expect(page).to have_selector ".likes_count", text: "#{current_count}"
      click_link "いいね"
    end
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_like_path(work, liked)
      expect(page).to have_selector ".likes_count", text: "#{current_count + 1}"
      click_link "いいねを取り消す"
    end
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_likes_path(work)
      expect(page).to have_selector ".likes_count", text: "#{current_count}"
    end
  end
end
