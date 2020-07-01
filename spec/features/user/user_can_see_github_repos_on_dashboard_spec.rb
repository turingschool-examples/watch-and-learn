require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a list of five of my github repos' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github-repos') do
        expect(page).to have_css(".user-repo", count: 5)
      end
    end
    # Not sure how to test this
    it 'Project names link to the repo on github' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to have_link("adopt_dont_shop_paired", :href => "https://github.com/Ashkanthegreat/adopt_dont_shop_paired")
      expect(page).to have_link("futbol", :href => "https://github.com/Lithnotep/futbol")
      expect(page).to have_link("monster_shop_2003", :href => "https://github.com/madhalle/monster_shop_2003")
      expect(page).to have_link("activerecord-obstacle-course", :href => "https://github.com/takeller/activerecord-obstacle-course")
      expect(page).to have_link("adopt_dont_shop_2003", :href => "https://github.com/takeller/adopt_dont_shop_2003")
    end

    it 'Does not display a github section if the user does not have a token' do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      expect(page).to_not have_css(".user-repo")
    end

    it 'Shows correct repos when there is more than one user with different github tokens' do
      user = create(:user, token:  ENV["GITHUB_API_TOKEN"])
      rostam = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within('#github-repos') do
        expect(page).to have_content("adopt_dont_shop_paired")
        expect(page).to have_content("futbol")
        expect(page).to have_content("monster_shop_2003")
        expect(page).to have_content("activerecord-obstacle-course")
        expect(page).to have_content("adopt_dont_shop_2003")
      end
    end
  end
end
