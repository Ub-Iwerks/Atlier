require 'rails_helper'

RSpec.describe 'Layouts', type: :system do
  before do
    driven_by(:rack_test)
  end

  it "check layouts has the number of links correctly" do
    visit root_path
    within("header") do
      expect(page).to have_link "Atlier", href: root_path
      expect(page).to have_link "ホーム", href: root_path
    end
    within("footer") do
      expect(page).to have_link "Contact", href: contact_path
      expect(page).to have_link "Atlier", href: root_path
    end
  end
end
