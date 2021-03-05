require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:base_title) { 'Atlier' }

  describe "GET /users/:id" do
    let(:user) { create(:user) }
    before do
      get user_path user
    end

    it "render show" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{user.username} | #{base_title}<\/title>/i)
    end
  end
end
