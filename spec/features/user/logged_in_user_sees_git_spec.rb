require 'rails_helper'

describe 'A registered user' do
  context 'when I visit /dashboard' do
    it 'sees a section for github' do
      VCR.use_cassette("dan_cassette") do
        user = create(:user, token: ENV["DAN_GIT_API_KEY"])
        conn = Faraday.new(url: "https://api.github.com") do |f|
          f.headers["Authorization"] = "Token #{user.token}"
          f.adapter Faraday.default_adapter
        end

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path


        expect(page).to have_content("GitHub Section")
        expect(page).to have_content("5 Repos")

        within ".top5repos" do
          expect(page).to have_content("https://github.com/asmolentzov/little-shop")
        end
      end
    end

    it 'only sees its git hub info ' do
      VCR.use_cassette("nico_cassette") do
        nico = create(:user, token: ENV["NICO_GIT_API_KEY"])
        dan = create(:user, token: ENV["DAN_GIT_API_KEY"])
        conn = Faraday.new(url: "https://api.github.com") do |f|
          f.headers["Authorization"] = "Token #{nico.token}"
          f.adapter Faraday.default_adapter
        end

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nico)

        visit dashboard_path


        expect(page).to have_content("GitHub Section")
        expect(page).to have_content("5 Repos")

        within ".top5repos" do
          expect(page).to have_content("https://github.com/asmolentzov/little-shop")
        end
      end
    end
    
    it 'does not see a section for github if it does not have a token' do
      VCR.use_cassette("no_token_cassette") do
        user = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path


        expect(page).to_not have_content("GitHub Section")
        expect(page).to_not have_content("Repos")
      end
    end
  end
end


# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
