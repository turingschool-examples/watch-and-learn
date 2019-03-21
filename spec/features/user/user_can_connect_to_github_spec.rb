require 'rails_helper'

describe 'A registered user without a github token' do
  context 'visiting /dashboard' do
    it 'can connect their account to github' do
      WebMock.disable!
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
      expect(page).to_not have_content("Followers")
      expect(page).to_not have_content("Following")

      click_on 'Connect To Github'

      expect(page).to_not have_link("Connect To Github'")
      expect(page).to have_content("Followers")
      expect(page).to have_content("Following")
    end
  end
end
