require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Egg' }

  describe "GET /" do
    before do
      get root_url
    end

    it "render home" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end

  describe "GET /static_pages/home" do
    before do
      get static_pages_home_url
    end

    it "render home" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end

  describe "GET /static_pages/help" do
    let(:page_title) { 'Help' }

    before do
      get static_pages_help_url
    end

    it "render help" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{page_title} - #{base_title}<\/title>/i)
    end
  end
end
