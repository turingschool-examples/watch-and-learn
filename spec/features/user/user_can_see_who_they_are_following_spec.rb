require 'rails_helper'

RSpec.describe 'User can see a list of users they are following' do
  describe 'As a logged in user, when I visit my dashboard' do
    describe 'in the Github section' do
      describe 'under the Following section' do
        it 'I see a list of users I follow where their handles are a link to their github profile' do

          user = create(:user)
          create(:github_token, user: user, token: ENV["USER_1_GITHUB_TOKEN"])

          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

          filename = 'users_that_user_1_follows.json'
          url = "https://api.github.com/user/following"

          stub_get_json(url,filename)

          visit '/dashboard'

          within '.github' do
            expect(page).to have_content("Following")
          end

          expect(page).to have_css('.following', count: 12)

          within(first('.following')) do
            expect(page).to have_css('.handle')
            expect(page).to have_link('jamisonordway', href: 'https://github.com/jamisonordway')
          end



        end
      end
    end
  end
#   As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see another section titled "Following"
# And I should see list of users I follow with their handles linking to their Github profile
end
