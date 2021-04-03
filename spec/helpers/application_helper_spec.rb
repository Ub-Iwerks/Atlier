require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let!(:user) { create(:user) }
  let(:another_user) { create(:user) }

  describe "text_url_to_link helper_method" do
    let(:text) { "https://example.com/" }
    let(:text_with_tag) { "<a href=https://example.com/ target=\"_blank\" rel=\"noopener\">https://example.com/</a>" }
    it "return text with link tag" do
      expect(text_url_to_link(text).html_safe).to eq text_with_tag
    end
  end

  describe "display_avatar_for helper_method" do
    let(:default_avatar) { Settings.default_image[:avatar] }
    let(:default_size) { Settings.avatar_size[:in_feed] }
    let(:specified_size) { Settings.avatar_size[:in_profile] }

    context "user doesnt attached avatar image" do
      subject { display_avatar_for(user) }

      before { user.avatar.purge }

      it "display default avatar with image tag" do
        is_expected.to eq image_tag(default_avatar, alt: "#{user.username}", class: "avatar", width: "#{default_size}px")
      end
    end
  end

  describe "unchecked_notifications helper_method" do
    subject { unchecked_notifications.present? }

    let(:current_user) { create(:user) }
    let!(:notification) { create(:notification, visited_id: current_user.id) }

    before do
      sign_in current_user
    end

    it "return true when user not checked notification" do
      is_expected.to eq true
    end

    it "return false when user checked notification" do
      notification.update(checked: true)
      is_expected.to eq false
    end
  end
end
