require 'rails_helper'

describe 'User' do
  it 'when I visit the dashboard I see a list of 5 repos' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("repos") do
      visit '/dashboard'

      expect(page).to have_css("#Github")
      expect(page).to have_content("Github")

      within "#Github" do
        expect(page).to have_css(".repository", count: 5)
        within(first(".repository")) do
          expect(page).to have_css(".name")

          url = "https://github.com/juliamarco/activerecord-obstacle-course"

          expect(page).to have_link("activerecord-obstacle-course", href: url)
        end
      end
    end
  end
end

# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
