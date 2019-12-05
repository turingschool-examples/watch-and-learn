require 'rails_helper'

RSpec.describe "As a logged in user" do
  context "When I visit my dashboard" do
    it "I should see a list of links to those I follow on GitHub" do
      VCR.use_cassette('github_following') do
        user = create(:user, github_token: ENV["Github_access_token"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#following" do
          within "#follow-0" do
            expect(page).to have_link
          end
          within "#follow-1" do
            expect(page).to have_link
          end
          within "#follow-2" do
            expect(page).to have_link
          end
          within "#follow-3" do
            expect(page).to have_link
          end
        end
      end
    end
  end
end
