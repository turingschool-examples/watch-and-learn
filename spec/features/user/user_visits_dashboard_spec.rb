require 'rails_helper'

describe 'as a user' do
  context 'when I visit the dashboard page' do
    context 'in the github section' do
      it 'shows me a list of repo names that are links to the repo' do
        user_1 = create(:user)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        VCR.use_cassette("Dashboard Github") {
          visit '/dashboard'
        }

        expect(page).to have_css('#GitHub')

        within '#GitHub' do
          expect(page).to have_css(".repository", count: 5)

          within(first('.repository')) do
            expect(page).to have_css(".name")
            within(".name") do
              # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github

            end
          end
        end
      end
    end
  end
end
