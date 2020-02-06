# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Following"
# And I should see list of users I follow with their handles linking to their Github pr

require 'rails_helper'

describe "When visting the dashboard as a logged in User" do
  it "can see a section for followers and their handles linking to their Github profile", :vcr do

    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    save_and_open_page
    # within "#github" do
    #   within "#following" do
    #     within(first('#following')) do 
    #       expect(page).to have_link
    #     end
    #     save_and_open_page
    #     expect(page).to have_css("p", count: 5)
    #   end
    # end

  end
end
