require 'rails_helper'

describe "As a logged in user" do
  before(:each) do
    user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])
    user_2 = create(:user, uid: 36653285)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "When I visit /dashboard", js: true do
    it "I should see an 'Add Friend' button next to the handle of a user within the database" do
      VCR.use_cassette('github_add_friend') do
        visit dashboard_path

        expect(page).to have_button("Add Friend")
        click_on "Add Friend"
        visit dashboard_path
        require 'pry'; binding.pry
      end
    end
  end
end
