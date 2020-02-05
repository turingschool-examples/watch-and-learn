require 'rails_helper'

describe "When visting the dashboard as a logged in User " do
  it "can see a section for 'Github' with 5 repo's", :vcr do
    user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within "#github" do
      within(first("#repo")) do
        expect(page).to have_link
      end
        expect(page).to have_css("p", count: 5)
    end
  end
end
