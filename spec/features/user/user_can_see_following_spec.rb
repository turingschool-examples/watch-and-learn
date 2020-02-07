require 'rails_helper'

describe 'As a logged in user, when I visit my dashboard' do
  context 'I see a list of who I follow in Github inside the Github Following Section' do
    it "Each Following's Github Handle is a link to their Gihub Profile", :vcr do
      user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      within("#following") do
        expect(page).to have_link
      end
    end
  end
end
