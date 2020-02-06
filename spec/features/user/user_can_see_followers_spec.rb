require 'rails_helper'

describe "When visting the dashboard as a logged in User" do
  it "can see a section for followers and their handles linking to their Github profile", :vcr do

    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within "#github" do
      within "#followers" do
        within(first('#follower')) do 
          expect(page).to have_link
        end
        expect(page).to have_css("p", count: 5)
      end
    end

  end
end
    
