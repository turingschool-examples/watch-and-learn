require 'rails_helper'


RSpec.describe "As a logged in user" do
  context "When I visit my dashboard" do
    it "I should see a list of 5 repo's with each Name as a link in 'Github' section" do
      VCR.use_cassette('user_github_repos') do
        user = create(:user, github_token: ENV["Github_access_token"])

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit '/dashboard'

        within "#Github" do
          expect(page).to have_link("")
          expect(page).to have_link("")
          expect(page).to have_link("")
          expect(page).to have_link("")
          expect(page).to have_link("")
        end
      end
    end
  end
end
