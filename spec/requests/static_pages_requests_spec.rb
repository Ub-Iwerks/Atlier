require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /static_pages/home" do
    before do
      get static_pages_home_url
    end

    it "render home" do
      expect(response.status).to eq 200
    end

    it 'have a greeting message to the world' do
      expect(response.body).to include "Hello World!!"
    end
  end
end
