require 'rails_helper'

RSpec.describe 'User following', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "View rendering test" do
    let!(:user) { create(:user) }
    let!(:users) { create_list(:user, 21) }
    let(:users_in_page) { users.take(20) }

    context "get following view" do
      before do
        users.each { |member| user.follow(member) }
      end

      it "rendering following member correctly" do
        sign_in user
        visit following_user_path user
        within(".pagination") do
          expect(page).to have_link href: "/users/#{user.id}/following?page=2"
        end
        users_in_page.each do |member|
          within("#user-#{member.id}") do
            expect(page).to have_link href: user_path(member.id), text: "#{member.username}"
            expect(page).to have_selector "img[alt$='#{member.username}']"
          end
        end
      end
    end

    context "get follower view" do
      before do
        users.each { |member| member.follow(user) }
      end

      it "rendering followers member correctly" do
        sign_in user
        visit followers_user_path user
        within(".pagination") do
          expect(page).to have_link href: "/users/#{user.id}/followers?page=2"
        end
        users_in_page.each do |member|
          within("#user-#{member.id}") do
            expect(page).to have_link href: user_path(member.id), text: "#{member.username}"
            expect(page).to have_selector "img[alt$='#{member.username}']"
          end
        end
      end
    end
  end

  describe "User follow and unfollow test" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let!(:following) { user.following.count }

    it "users following count change" do
      sign_in user
      visit user_path another_user
      within("form") do
        click_button "フォロー"
      end
      expect(current_path).to eq user_path another_user
      expect(user.following.count).to eq following + 1
      within("form") do
        click_button "フォロー中"
      end
      expect(current_path).to eq user_path another_user
      expect(user.following.count).to eq following
    end
  end
end
