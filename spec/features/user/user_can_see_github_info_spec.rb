require 'rails_helper'

feature 'users can see github info' do
  context "when I visit /dashboard" do

    before(:each) do
      @user = create(:user, access_token: ENV['GITHUB_TOKEN_KEY'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it 'shows 5 of my repos', :vcr do
      expect(page).to have_content('Github')
      expect(page).to have_css('.github-repos')
      expect(page).to have_css('.repo', count: 5)
    end

    it 'shows my followers', :vcr do
      expect(page).to have_content('Followers')
      expect(page).to have_css('.github-followers')
      expect(page).to have_css('.follower')
    end

    it 'shows my followings', :vcr do
      expect(page).to have_content('Following')
      expect(page).to have_css('.github-followings')
      expect(page).to have_css('.following')
    end
  end
end
