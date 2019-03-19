require 'rails_helper'

describe "User" do
  it 'can see a list of followers' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("followers") do
      visit '/dashboard'

      expect(page).to have_css("#followers")
      expect(page).to have_content("Followers")

      within "#followers" do
        expect(page).to have_css(".follower")
        within(first(".follower")) do
          expect(page).to have_css(".handle")

          url = "https://github.com/timnallen"
          expect(page).to have_link("timnallen", href: url)
        end
      end
    end
  end
end
