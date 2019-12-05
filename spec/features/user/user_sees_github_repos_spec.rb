require 'rails_helper'

describe 'User' do
  describe "When I visit my dashboard", :vcr do
    before(:each) do
      @user = create(:user, token: ENV['USER_GITHUB_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit '/dashboard'
    end

    it "I see a Github section with 5 of my repos, where each name is a link" do
      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Github Repositories')
      expect(page).to have_css('.github-repo', count: 5)
    end
  end
end
