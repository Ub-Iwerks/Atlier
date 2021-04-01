require 'rails_helper'

RSpec.describe 'Create work', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  # csv_file_path = Rails.root.join('spec/fixtures/sample.csv')
  let(:file_path) { Rails.root.join('spec/fixture/files/test.jpeg') }
  let(:title) { 'TITLE' }
  let(:concept) { 'This is a concept' }
  let(:description) { 'This is a description' }

  let!(:work_create) { build(:work_create, user_id: user.id) }

  let(:illustration_name) { 'This is a illustrations name' }
  let(:illustration_description) { 'This is a illustrations description' }
  let(:current_work) { Work.first }

  it "check work feed has links correctly" do
    sign_in user
    visit new_work_path
    within("form") do
      # fill_in "work_create[category_id]", with: category.id
      fill_in "work_create[title]", with: title
      fill_in "work_create[concept]", with: concept
      fill_in "work_create[description]", with: description
      # find('#work_create_image').set(file_path)
      # attach_file "work_create[image]", file_path
      fill_in "work_create[illustrations_attributes][0][name]", with: illustration_name
      fill_in "work_create[illustrations_attributes][0][description]", with: illustration_description
      # attach_file "work_create[illustrations_attributes][0][photo]", file_path
      click_button "登録する"
    end
    expect(current_path).to eq work_path(current_work)
    within(".work_info") do
      expect(page).to have_selector "img[src$='#{current_work.image.filename}']"
      expect(page).to have_selector "h3", text: "#{current_work.title}"
      expect(page).to have_selector "h4", text: "#{current_work.concept}"
      expect(page).to have_selector "p", text: "#{current_work.description}"
    end
    within(".work_sub_info") do
      current_work.illustrations.each do |illustration|
        within("li#illustration-#{illustration.id}") do
          expect(page).to have_selector "img[src$='#{illustration.photo.filename}']"
          expect(page).to have_selector ".name", text: "#{illustration.name}"
          expect(page).to have_selector ".description", text: "#{illustration.description}"
        end
      end
    end
  end
end
