require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a list of my github followers' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'
      within('#github-followers') do
        expect(page).to have_content("HughBerriez")
        expect(page).to have_content("rickbacci")
        expect(page).to have_css(".follower-handle", count:2)
      end
    end

    it 'has a link to the github followers handles' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

        expect(page).to have_link("HughBerriez", :href => "https://github.com/HughBerriez")
        expect(page).to have_link("rickbacci", :href => "https://github.com/rickbacci")
    end

    it 'Does not display a github followers section if the user does not have a token' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_css(".github_followers")
    end

    it 'Shows correct followers when there is more than one user with different github tokens' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN"])
      rostam = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(rostam)

      visit '/dashboard'

      within('#github-followers') do
        expect(page).to have_content("HughBerriez")
        expect(page).to have_content("rickbacci")
      end
    end
  end

end
