require 'rails_helper'

RSpec.describe Work, type: :model do
  describe "Validations test" do
    subject { work }

    let(:work) { build(:work) }

    context "work has valid imformatioin" do
      it { is_expected.to be_valid }
    end

    context "work doesnt have association to user" do
      let(:work) { build(:work, user: nil) }
      it { is_expected.not_to be_valid }
    end

    context "work doesnt have title" do
      let(:title) { " " * 50 }
      let(:work) { build(:work, title: title) }
      it { is_expected.not_to be_valid }
    end

    context "work has too long title" do
      let(:title) { "a" * 51 }
      let(:work) { build(:work, title: title) }
      it { is_expected.not_to be_valid }
    end

    context "work has too long concept" do
      let(:concept) { "a" * 301 }
      let(:work) { build(:work, concept: concept) }
      it { is_expected.not_to be_valid }
    end

    context "work have too long description" do
      let(:description) { "a" * 301 }
      let(:work) { build(:work, description: description) }
      it { is_expected.not_to be_valid }
    end

    context "work doesnt have image" do
      before { work.image = nil }

      let(:work) { build(:work) }
      it { is_expected.not_to be_valid }
    end

    context "works array" do
      let(:now) { Time.current }
      let(:yesterday) { 1.day.ago }
      let(:one_week_ago) { 1.week.ago }
      let(:user) { create(:user) }
      let!(:one_week_ago_work) { create(:work, created_at: one_week_ago, user: user) }
      let!(:yesterday_work) { create(:work, created_at: yesterday, user: user) }
      let!(:now_work) { create(:work, created_at: now, user: user) }
      it "line up more recnt" do
        expect(user.works).to eq [now_work, yesterday_work, one_week_ago_work]
      end
    end
  end

  describe "Test related to other model" do
    context "destroyed work has illustration" do
      let!(:work) { create(:work) }
      let!(:illustration) { create(:illustration, work: work) }
      let!(:count) { Illustration.count }
      it "work related to user are destroyed" do
        work.destroy
        expect(Illustration.count).to eq count - 1
      end
    end

    context "destroyed work has comment" do
      let!(:work) { create(:work) }
      let!(:comment) { create(:comment, work: work) }
      let!(:count) { Comment.count }
      it "comment related to user are destroyed" do
        work.destroy
        expect(Comment.count).to eq count - 1
      end
    end
  end

  describe "Method test" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:third_user) { create(:user) }
    let(:work) { create(:work, user: user) }

    describe "create_notification_like" do
      context "another_user likes the work created by user" do
        let(:notification) do
          Notification.find_by(visitor_id: another_user.id, visited_id: user.id, work_id: work.id, action: "like")
        end

        before { work.create_notification_like(another_user) }

        it "created notification" do
          expect(notification).to be_truthy
        end

        it "notification checked false" do
          expect(notification.checked).to be_falsey
        end
      end

      context "user likes own work" do
        let(:notification) do
          Notification.find_by(visitor_id: user.id, visited_id: user.id, work_id: work.id, action: "like")
        end

        before { work.create_notification_like(user) }

        it "created notification" do
          expect(notification).to be_truthy
        end

        it "notification checked true" do
          expect(notification.checked).to be_truthy
        end
      end

      context "another_user likes work twice" do
        subject { work.create_notification_like(another_user) }

        let!(:notification) do
          create(:notification, visitor_id: another_user.id, visited_id: user.id, work_id: work.id, action: "like")
        end

        it "dont create notification again" do
          is_expected.to be_falsey
        end
      end
    end

    describe "save_notification_comment" do
      context "another_user comments the work created by user" do
        let!(:comment) { create(:comment, user: another_user, work: work) }
        let(:notification) do
          Notification.find_by(visitor_id: another_user.id, visited_id: user.id, work_id: work.id, action: "comment",
                               comment_id: comment.id)
        end

        before { work.save_notification_comment(another_user, comment.id, user.id) }

        it "created notification" do
          expect(notification).to be_truthy
        end

        it "notification checked false" do
          expect(notification.checked).to be_falsey
        end
      end

      context "user comments own work" do
        let!(:comment) { create(:comment, user: user, work: work) }
        let(:notification) do
          Notification.find_by(visitor_id: user.id, visited_id: user.id, work_id: work.id, action: "comment",
                               comment_id: comment.id)
        end

        before { work.save_notification_comment(user, comment.id, user.id) }

        it "not created notification" do
          expect(notification).to be_nil
        end
      end
    end

    describe "create_notification_comment" do
      let!(:count) { Notification.count }
      let!(:comment) { create(:comment, work: work, user: another_user) }
      context "first other user comments to work created by user" do
        let(:notification) do
          Notification.find_by(visitor_id: another_user.id, visited_id: user.id, work_id: work.id, action: "comment",
                               comment_id: comment.id)
        end

        before { work.create_notification_comment(another_user, comment.id) }

        it "create notification to user" do
          expect(notification).to be_truthy
        end

        it "create only one notification" do
          expect(Notification.count).to eq count + 1
        end
      end

      context "second other user comments to work created by user" do
        let!(:another_comment) { create(:comment, work: work, user: third_user) }
        let(:notification_to_user) do
          Notification.find_by(visited_id: user.id, visitor_id: third_user.id, work_id: work.id, action: "comment",
                               comment_id: another_comment.id)
        end
        let(:notification_to_another_user) do
          Notification.find_by(visited_id: another_user.id, visitor_id: third_user.id, work_id: work.id, action: "comment",
                               comment_id: another_comment.id)
        end

        before { work.create_notification_comment(third_user, another_comment.id) }

        it "create notification to user" do
          expect(notification_to_user).to be_truthy
        end

        it "create notification to another_user" do
          expect(notification_to_another_user).to be_truthy
        end

        it "create only one notification" do
          expect(Notification.count).to eq count + 2
        end
      end
    end
  end
end
