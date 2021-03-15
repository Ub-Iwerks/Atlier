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
        users.each do |member|
          user.follow(member)
        end
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
            expect(page).to have_selector "span.email", text: "#{member.email}"
          end
        end
      end
    end

    context "get follower view" do
      before do
        users.each do |member|
          member.follow(user)
        end
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
            expect(page).to have_selector "span.email", text: "#{member.email}"
          end
        end
      end
    end
  end
end
