require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  let(:base_title) { 'Atlier' }

  describe "GET /user/signup" do
    let(:page_title) { '新規登録' }
    before do
      get new_user_registration_path
    end

    it "render new" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{page_title} | #{base_title}<\/title>/i)
    end
  end

  describe "POST /users" do
    let(:username) { "test_user" }
    let(:email) { "test@example.com" }
    let(:password) { "password" }
    let(:user) { User.find_by(email: email) }
    before do
      post user_registration_path, params: {
        user: {
          username: username,
          email: email,
          password: password,
          password_confirmation: password,
        },
      }
    end

    it "create user" do
      expect(user).to be_truthy
    end

    it "render show" do
      expect(response).to redirect_to root_path
    end
  end

  describe "GET /users/edit" do
    let(:user) { create(:user) }
    let(:page_title) { "プロフィールを編集" }
    before do
      sign_in user
      get edit_user_registration_path(user)
    end

    it "render edit" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{page_title} | #{base_title}<\/title>/i)
    end
  end

  describe "PATCH /users" do
    let!(:user) { create(:user) }
    let(:changed_username) { "changed_user" }
    let(:changed_email) { "changed@exmple.com" }
    before do
      sign_in user
      put user_registration_path, params: {
        user: {
          username: changed_username,
          email: changed_email,
        },
      }
    end

    it "update successliy" do
      expect(response.status).to eq 302
    end

    it 'check updated username' do
      expect(User.find(user.id).username).to eq changed_username
    end
  end

  describe "DELETE /users" do
    let!(:user) { create(:user) }
    let!(:count) { User.count }
    before do
      sign_in user
      delete user_registration_path, params: {
        user: {
          username: user.username,
          email: user.email,
        },
      }
    end

    it "delete successliy" do
      expect(response.status).to eq 302
    end

    it 'check user deleted' do
      expect(User.count).to eq count - 1
    end
  end

  describe "GET /users/:id/edit_password" do
    let(:user) { create(:user) }
    let(:page_title) { "パスワードを変更" }

    context "user not sign in" do
      before { get edit_password_path }

      it "redirect to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in" do
      before do
        sign_in user
        get edit_password_path
      end

      it "render edit_password" do
        expect(response.status).to eq 200
      end

      it 'have page_title of title tag' do
        expect(response.body).to match(/<title>#{page_title} | #{base_title}<\/title>/i)
      end
    end
  end

  describe "PUT /users/edit_password" do
    let(:user) { create(:user) }
    let(:current_password) { "#{user.password}" }
    let(:new_password) { "new_password" }

    context "user not sign in" do
      before do
        put update_password_path, params: {
          user: {
            current_password: current_password,
            password: new_password,
            password_confirmation: new_password,
          },
        }
      end

      it "redirect to sign in view" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "user signed in and has correct imformation" do
      before do
        sign_in user
        put update_password_path, params: {
          user: {
            current_password: current_password,
            password: new_password,
            password_confirmation: new_password,
          },
        }
      end

      it "render edit_password" do
        expect(response.status).to eq 302
      end
    end
  end
end
