require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "Validatioins test" do
    subject { user }

    context "user has valid imformation" do
      let(:user) { build(:user, username: "example", email: "test@exmpale.com") }
      it { is_expected.to be_valid }
    end

    context "user doesnt have name" do
      let(:user) { build(:user, username: " ") }
      it { is_expected.not_to be_valid }
    end

    context "user doesnt have email" do
      let(:user) { build(:user, email: " ") }
      it { is_expected.not_to be_valid }
    end

    context "user has too long name" do
      let(:user) { build(:user, username: "a" * 51) }
      it { is_expected.not_to be_valid }
    end

    context "user has too long email" do
      let(:user) { build(:user, email: "a" * 244 + "@example.com") }
      it { is_expected.not_to be_valid }
    end

    context "user has valid email" do
      valid_emails = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
      valid_emails.each do |email|
        let(:user) { build(:user, email: email) }
        it { is_expected.to be_valid }
      end
    end

    context "user has invalid email" do
      invalid_emails = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
      invalid_emails.each do |email|
        let(:user) { build(:user, email: email) }
        it { is_expected.not_to be_valid }
      end
    end

    context "user has same email" do
      let(:origin_user) { create(:user, email: "test@exmpale.com") }
      let(:user) { build(:user, email: origin_user.email) }
      it { is_expected.not_to be_valid }
    end

    context "user has blank password" do
      let(:password) { " " * 8 }
      let(:user) { build(:user, password: password, password_confirmation: password) }
      it { is_expected.not_to be_valid }
    end

    context "user has short password" do
      let(:password) { "a" * 7 }
      let(:user) { build(:user, password: password, password_confirmation: password) }
      it { is_expected.not_to be_valid }
    end

    context "user has missmatch of password and password_confirmation" do
      let(:password) { "password" }
      let(:password_confirmation) { "abcd1234" }
      let(:user) { build(:user, password: password, password_confirmation: password_confirmation) }
      it { is_expected.not_to be_valid }
    end
  end
end
