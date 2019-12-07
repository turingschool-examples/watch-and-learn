require 'rails_helper'

describe 'User' do
  describe "When I visit my dashboard", :vcr do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it "I see a Connect to Github button if not connected" do
      expect(page).to have_button("Connect to Github")
    end

    it 'can connect with Github OAuth and see 5 repos' do
      click_button "Connect to Github"
  
      expect(page.status_code).to eq(200)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Github Repositories')
      expect(page).to have_css('.github-repo', count: 5)
    end
  end
end
