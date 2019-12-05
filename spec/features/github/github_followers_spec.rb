require 'rails_helper'

RSpec.describe "As a logged in user" do
  context "When I visit my dashboard" do
    it "I should see a list of links to Followers in a section below my 'Github' section" do
      VCR.use_cassette('user_github_followers') do
        user = create(:user, github_token: ENV["Github_access_token"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#Followers" do
          within "#follower-0" do
            expect(page).to have_link
          end
          within "#follower-1" do
            expect(page).to have_link
          end
          within "#follower-2" do
            expect(page).to have_link
          end
        end
      end
    end
  end
end
