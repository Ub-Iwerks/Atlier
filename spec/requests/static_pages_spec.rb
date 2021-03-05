require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  let(:base_title) { 'Atlier' }

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

  describe "GET /contact" do
    let(:page_title) { 'Contact' }

    before do
      get contact_url
    end

    it "render contact" do
      expect(response.status).to eq 200
    end

    it 'have page_title of title tag' do
      expect(response.body).to match(/<title>#{page_title} - #{base_title}<\/title>/i)
    end
  end
end
