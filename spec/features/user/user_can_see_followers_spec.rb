require 'rails_helper'

describe 'As a logged in user, when I visit my dashboard' do
  context 'I see a list of Github Followers inside the Github Followers Section' do
    it "Each Follower's Github Handle is a link to their Gihub Profile", :vcr do
      user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within("#followers") do
        expect(page).to have_link
      end
    end
  end
end
