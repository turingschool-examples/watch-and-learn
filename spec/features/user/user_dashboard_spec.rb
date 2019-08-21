require 'rails_helper'
  describe 'As a logged in user' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
    end

  describe 'When I visit /dashboard' do
    it "I am taken to my user dashboard and I see a section for github. Under that section I should see a list" do
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Github")
      expect(page).to have_content(JSON)

      within(first(".repo")) do
        expect(page).to have_css(".name")
        expect(page).to have_css(".url")

      end
    end
  end
end
