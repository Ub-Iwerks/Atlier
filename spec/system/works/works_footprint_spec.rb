require 'rails_helper'

RSpec.describe 'Works footprint', type: :system, js: true do
  let(:works_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:work) { create(:work, user_id: works_user.id) }
  let!(:footprint_by_another_user) { create(:footprint, work_id: work.id, user_id: another_user.id, counts: 10) }
  let!(:footprint_by_other_user) { create(:footprint, work_id: work.id, user_id: other_user.id, counts: 10) }

  it "check footprint counts of work" do
    sign_in other_user
    footprint_counts_by_other_user = Footprint.select(:counts).find_by(work_id: work.id, user_id: other_user.id).counts
    expect do
      visit work_path work
      footprint_counts_by_other_user = Footprint.select(:counts).find_by(work_id: work.id, user_id: other_user.id).counts
    end.to change { footprint_counts_by_other_user }.from(10).to(11)
    expect(current_path).to eq work_path(work)
    within("section.work--assessment__aside") do
      expect(page).to have_selector "div.work__footprints",
                                    text: "#{footprint_by_another_user.counts + footprint_by_other_user.counts + 1}"
    end
    visit current_path
    within("section.work--assessment__aside") do
      expect(page).to have_selector "div.work__footprints",
                                    text: "#{footprint_by_another_user.counts + footprint_by_other_user.counts + 2}"
    end
  end
end
