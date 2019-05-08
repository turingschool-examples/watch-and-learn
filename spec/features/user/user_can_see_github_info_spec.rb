require 'rails_helper'

feature "users can see github info" do
  context "when I visit /dashboard" do

    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it "shows 5 of my repos", :vcr do
      expect(page).to have_content("Github")
      expect(page).to have_css(".github-repos")
      expect(page).to have_css(".repos", count: 5) 
    end
  end
end
