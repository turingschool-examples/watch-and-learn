require 'rails_helper'

RSpec.describe 'Get started page' do
  describe 'content' do
    it 'has a title' do
      visit get_started_path

      expect(page).to have_content("Get Started")
    end
    it 'has a list paragraph' do
      visit get_started_path

      expect(page).to have_content("Browse tutorials from the homepage.")
      expect(page).to have_link("homepage", href: root_path)
      expect(page).to have_content("Filter results by selecting a filter on the side bar of the homepage.")
      expect(page).to have_content("Register to bookmark segments.")
      expect(page).to have_content("Sign in with census if you are a current student for additional content.")
      expect(page).to have_link("Sign in", href: login_path)
    end
  end

  describe 'As any kind of user' do
    it 'can see about page' do
      visit '/about'

      click_on 'Get Started'

      expect(current_path).to eq(get_started_path)

      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/about'

      click_on 'Get Started'

      expect(current_path).to eq(get_started_path)

      admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit '/about'

      click_on 'Get Started'

      expect(current_path).to eq(get_started_path)
    end
  end
end
