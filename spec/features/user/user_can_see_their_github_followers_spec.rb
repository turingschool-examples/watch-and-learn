require 'rails_helper'

RSpec.describe 'User can see their Github followers' do
  describe 'As a logged in user, in my dashboard' do
    describe 'under the Github section' do
      it 'I see a followers section' do
        user = create(:user)
        create(:github_token, user: user, token: ENV['USER_1_GITHUB_TOKEN'])
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        stub_user_1_dashboard

        visit '/dashboard'

        expect(page).to have_content("My Followers")

        expect(page).to have_css('.user_follower', count: 9)

        within(first('.user_follower')) do
          expect(page).to have_css('.name')
          expect(page).to have_link('Mackenzie-Frey', href: "https://github.com/Mackenzie-Frey")
        end
      end
    end
  end
end
