require 'rails_helper'

describe 'As a registered user' do
  describe 'When I visit the dashboard' do
    it 'I see a list of five of my github repos' do
      user = create(:user, token:  "6d37f331aab131ad424243bdf9065ecc18e809be")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'


      within('#github-repos') do
        expect(find('ul.text')).to have_selector('li', count: 5)
      end
    end

    it 'Project names link to the repo on github' do

    end

    it 'Does not display a github section if the user does not have a token' do

    end
  end
end
