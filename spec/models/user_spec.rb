require 'rails_helper'

RSpec.describe User, type: :model do
 let(:user) { build(:user) }

  describe "Validatioins Test" do
    context "user has valid date" do
      let(:user) { build(:user, username: "example", email: "test@exmpale.com") }
      it "is valid" do
        expect(user).to be_valid
      end
    end

    context "user doesnt have name" do
      let(:user) { build(:user, username: " ") }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end

    context "user doesnt have email" do
      let(:user) { build(:user, email: " ") }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end

    context "user has too long name" do
      let(:user) { build(:user, username: "a" * 51) }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end

    context "user has too long email" do
      let(:user) { build(:user, email: "a" * 244 + "@example.com") }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end

    context "user has valid email" do
      valid_emails = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
      valid_emails.each do |email|
        let(:user) { build(:user, email: email) }
        it "is valid" do
          expect(user).to be_valid
        end
      end
    end

    context "user has invalid email" do
      invalid_emails = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
      invalid_emails.each do |email|
        let(:user) { build(:user, email: email) }
        it "is not valid" do
          expect(user).not_to be_valid
        end
      end
    end

    context "user has same email" do
      let(:user) { create(:user, email: "test@exmpale.com") }
      let(:dup_user) { build(:user, email: user.email) }
      it "is not valid" do
        expect(dup_user).not_to be_valid
      end
    end

    context "user has blank password" do
      password_text = " " * 6
      let(:user) { build(:user, password: password_text, password_confirmation: password_text) }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end

    context "user has short password" do
      password_text = "a" * 5
      let(:user) { build(:user, password: password_text, password_confirmation: password_text) }
      it "is not valid" do
        expect(user).not_to be_valid
      end
    end
  end
end
