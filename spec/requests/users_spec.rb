require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:base_title) { 'Atlier' }

  describe "GET /users/:id" do
    let(:user) { create(:user) }
    before { get user_path user }

    it "render show" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{user.username} | #{base_title}<\/title>/i)
    end
  end

  describe "GET /users/:id/following" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:title) { "フォロー" }

    context "user doesnt sign in" do
      before { get following_user_path user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        sign_in user
        get following_user_path user
      end

      it "render show_follow" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{user.username}の#{title} | #{base_title}<\/title>/i)
      end
    end
  end

  describe "GET /users/:id/followers" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:title) { "フォロワー" }

    context "user doesnt sign in" do
      before { get followers_user_path user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        get followers_user_path user
      end

      it "render show_follow" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{user.username}の#{title} | #{base_title}<\/title>/i)
      end
    end
  end

  describe "GET /users/index" do
    let(:title) { "ユーザー一覧" }
    let(:user) { create(:user) }

    context "user doesnt sign in" do
      before { get users_path }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        get users_path
      end

      it "render show_follow" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{title} | #{base_title}<\/title>/i)
      end
    end
  end

  describe "POST /users/:id/favorites" do
    let(:user) { create(:user) }

    context "user doesnt sign in" do
      before { post favorites_user_path user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "GEST /users/:id/stocks" do
    let(:user) { create(:user) }
    let(:base_site) { "#{user.username}" }
    let(:base_title) { "保存した作品" }

    context "user sign in" do
      before do
        sign_in user
        get stocks_user_path user
      end

      it "render works/stocks.html.erb" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{base_title} | #{base_site}<\/title>/i)
      end
    end

    context "user doesnt sign in" do
      before { get stocks_user_path user }

      it "redirect_to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
