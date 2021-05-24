require "rails_helper"

RSpec.describe "Liked work", type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:third_user) { create(:user) }
  let(:work) { create(:work, user: user) }
  let(:another_work) { create(:work, user: user) }
  let!(:like) { create(:like, user: another_user, work: work) }
  let!(:like_by_third_user) { create(:like, user: third_user, work: work) }
  let!(:current_count) { work.likes.count }
  let(:liked) { Like.find_by(user_id: user.id, work_id: work.id) }

  it "display and create, destroy likes" do
    sign_in user
    visit work_path work
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_likes_path(work)
      expect(page).to have_selector ".likes_count", text: "#{current_count}"
      find(".like_btn").click
    end
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_like_path(work, liked)
      expect(page).to have_selector ".likes_count", text: "#{current_count + 1}"
      find(".like_btn").click
    end
    within("div#likes_button-#{work.id}") do
      expect(page).to have_link href: work_likes_path(work)
      expect(page).to have_selector ".likes_count", text: "#{current_count}"
    end
  end

  context "user had liked a work" do
    it "display works user liked" do
      sign_in another_user
      visit user_path another_user
      expect(current_path).to eq user_path another_user
      within(".user--works") do
        within("ul.user--works__types") do
          expect(page).to have_link "作品一覧", href: user_path(another_user)
          expect(page).to have_link "いいね一覧", href: user_likes_path(another_user)
          click_link "いいね一覧"
        end
      end
      expect(current_path).to eq user_likes_path another_user
      within(".user--info") do
        expect(page).to have_selector "img[alt='#{another_user.username}']"
        expect(page).to have_selector "h1", text: "#{another_user.username}"
      end
      within("section.user--works") do
        within("ul.user--works__types") do
          expect(page).to have_link "作品一覧", href: user_path(another_user)
          expect(page).to have_link "いいね一覧", href: user_likes_path(another_user)
        end
        within("ol.works") do
          within("li#work-#{work.id}") do
            expect(page).to have_link "#{work.title}", href: work_path(work)
          end
        end
      end
    end
  end

  context "user had not liked a work" do
    it "display no works user liked" do
      sign_in user
      visit user_path user
      within(".user--works") do
        within("ul.user--works__types") do
          expect(page).to have_link "作品一覧", href: user_path(user)
          expect(page).to have_link "いいね一覧", href: user_likes_path(user)
          click_link "いいね一覧"
        end
      end
      expect(current_path).to eq user_likes_path user
      within(".user--info") do
        expect(page).to have_selector "img[alt='#{user.username}']"
        expect(page).to have_selector "h1", text: "#{user.username}"
      end
      within("section.user--works") do
        within("ul.user--works__types") do
          expect(page).to have_link "作品一覧", href: user_path(user)
          expect(page).to have_link "いいね一覧", href: user_likes_path(user)
        end
        expect(page).to have_selector "h4", text: "いいねした作品がありません"
      end
    end
  end
end
