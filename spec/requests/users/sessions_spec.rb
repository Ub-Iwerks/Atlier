require "rails_helper.rb"

RSpec.describe "Sessions", type: :request do
  describe "Get /users/sign_in" do
    before do
      get new_user_session_path
    end

    it "render new" do
      expect(response.status).to eq 200
    end
  end
end