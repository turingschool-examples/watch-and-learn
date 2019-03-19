require 'rails_helper'

feature 'As a logged in user' do
  context 'when visiting /dashboard' do
    it 'sees a list of five repos' do

      user = create(:user)

      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to have_content("Github")
      expect(page).to have_css(".github")
      expect(page).to have_css(".repo", count: 5)
      within(first(".repo")) do
        expect(page).to have_css(".repo-name")
        expect(page).to have_link("Repo Name")
      end
    end
  end
end
