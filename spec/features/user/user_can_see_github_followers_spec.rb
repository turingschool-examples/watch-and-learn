require 'rails_helper'

describe "As a logged in user" do
  before(:each) do
    @user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    stub_login(@user)
  end

  describe "When I visit '/dashboard'" do
    it "Under the 'Github' section I should see a 'Followers' subsection" do
      # GET api.github.com/user/followers
      # returns array of user hashes

      VCR.use_cassette("github-user-followers") do
        visit dashboard_path

        within("section#github") do
          within "#followers" do
            expect(page).to have_css(".follower")

            within first(".follower") do
              expect(page).to have_css(".user-link")
            end
          end
        end
      end
    end
  end
end
