require 'rails_helper'

RSpec.describe 'Admin dashboard page' do
  feature "As an admin visiting the admin dashboard" do
    scenario "can see all tutorials" do
      admin = create(:admin)
      create_list(:tutorial, 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit "/admin/dashboard"

      expect(page).to have_css(".admin-tutorial-card", count: 2)
    end
  end

  feature "As a regular user visiting the admin dashboard" do
    scenario "sees a 404 error" do
      user = create(:user)
      create_list(:tutorial, 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/admin/dashboard"

      expect(page).to have_content("The page you're looking for could not be found.")
    end
  end
end
