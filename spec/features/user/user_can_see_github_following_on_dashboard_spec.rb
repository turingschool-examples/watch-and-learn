require 'rails_helper'

# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Following"
# And I should see list of users I follow with their handles linking to their Github profile

describe 'As a logged in user' do
  describe 'visiting their dashboard' do
    describe 'I see a section for Following' do

      it 'shows a list of my github following' do
        user = create(:user, github_token: ENV["GITHUB_PAT"])

        visit '/'

        click_link 'Sign In'

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password

        click_on "Log In"

        within "#following" do
          expect(page).to have_content("Following")
          expect(page).to have_all_of_selectors("#following-1", "#following-2", "#following-3", "#following-4", "#following-5")
        end
      end

    end
  end
end
