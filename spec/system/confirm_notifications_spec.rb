require 'rails_helper.rb'

RSpec.describe "Confirm notification", type: :system do
  before { driven_by(:rack_test) }

  let(:user) { create(:user) }
  let(:second_user) { create(:user) }
  let(:third_user) { create(:user) }
  let(:work) { create(:work, user: user) }

  describe "follow notification test" do
    let(:notification) do
      Notification.find_by(action: "follow", visitor_id: second_user.id, visited_id: user.id)
    end
    it "confirm notification and change site layouts" do
      sign_in second_user
      visit user_path user
      within(".follow_form") do
        click_button "フォロー"
      end
      sign_out second_user
      sign_in user
      visit root_path
      within(".header--nav") do
        expect(page).to have_selector "span.unchecked"
      end
      visit notifications_path
      within("li#notification-#{notification.id}") do
        expect(page).to have_link "#{second_user.username}", href: user_path(second_user)
        expect(page).to have_selector "span", text: "あなたをフォローしました"
        expect(page).to have_selector ".notification__unchecked"
      end
      visit current_path
      within(".header--nav") do
        expect(page).not_to have_selector "span.unchecked"
      end
      within("li#notification-#{notification.id}") do
        expect(page).not_to have_selector ".notification__unchecked"
      end
    end
  end

  describe "like notification test" do
    let(:notification) do
      Notification.find_by(action: "like", visitor_id: second_user.id, visited_id: user.id, work_id: work.id)
    end
    it "confirm notification and change site layouts" do
      sign_in second_user
      visit work_path work
      within("div#likes_button-#{work.id}") do
        find(".like_btn").click
      end
      sign_out second_user
      sign_in user
      visit root_path
      within(".header--nav") do
        expect(page).to have_selector "span.unchecked"
      end
      visit notifications_path
      within("li#notification-#{notification.id}") do
        expect(page).to have_link "#{second_user.username}", href: user_path(second_user)
        expect(page).to have_link "#{work.title}", href: work_path(work)
        expect(page).to have_selector ".notification__unchecked"
      end
      visit current_path
      within(".header--nav") do
        expect(page).not_to have_selector "span.unchecked"
      end
      within("li#notification-#{notification.id}") do
        expect(page).not_to have_selector ".notification__unchecked"
      end
    end
  end

  describe "comment notification" do
    let!(:comment_by_second_user) { create(:comment, work_id: work.id, user_id: second_user.id) }
    let(:comment_content) { "This is the comment" }
    let(:comment) { Comment.find_by(work_id: work.id, user_id: third_user.id, content: comment_content) }
    let(:notification) do
      Notification.find_by(action: "comment", visitor_id: third_user.id, work_id: work.id, comment_id: comment.id,
                           visited_id: user.id)
    end
    let(:notification_to_second) do
      Notification.find_by(action: "comment", visitor_id: third_user.id, work_id: work.id, comment_id: comment.id,
                           visited_id: second_user.id)
    end
    it "confirm notification and change site layouts" do
      sign_in third_user
      visit work_path work
      within("section.comments_to_work_aside") do
        fill_in "comment[content]", with: comment_content
        click_button "投稿"
      end
      sign_out third_user
      sign_in user
      visit root_path
      within(".header--nav") do
        expect(page).to have_selector "span.unchecked"
      end
      visit notifications_path
      within("li#notification-#{notification.id}") do
        expect(page).to have_link "#{third_user.username}", href: user_path(third_user)
        within(".commented_work") do
          expect(page).to have_link "#{work.title}", href: work_path(work)
          expect(page).not_to have_link "#{user.username}", href: user_path(user)
        end
        expect(page).to have_selector ".notification__comment", text: "#{comment_content}"
        expect(page).to have_selector ".notification__unchecked"
      end
      visit current_path
      within(".header--nav") do
        expect(page).not_to have_selector "span.unchecked"
      end
      within("li#notification-#{notification.id}") do
        expect(page).not_to have_selector ".notification__unchecked"
      end
      sign_out user
      sign_in second_user
      visit root_path
      within(".header--nav") do
        expect(page).to have_selector "span.unchecked"
      end
      visit notifications_path
      within("li#notification-#{notification_to_second.id}") do
        expect(page).to have_link "#{third_user.username}", href: user_path(third_user)
        within(".commented_work") do
          expect(page).to have_link "#{work.title}", href: work_path(work)
          expect(page).to have_link "#{user.username}", href: user_path(user)
        end
        expect(page).to have_selector ".notification__comment", text: "#{comment_content}"
        expect(page).to have_selector ".notification__unchecked"
      end
      visit current_path
      within(".header--nav") do
        expect(page).not_to have_selector "span.unchecked"
      end
      within("li#notification-#{notification_to_second.id}") do
        expect(page).not_to have_selector ".notification__unchecked"
      end
    end
  end
end
