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
    let(:user) { User.find_by(email: email)}
    before do
      post user_registration_path, params: { user: { username: username, email: email, password: password, password_confirmation: password } }
    end

    it "create user" do
      expect(user).to be_truthy
    end

    it "render show" do
      expect(response).to redirect_to user_path(user)
    end
  end
end
