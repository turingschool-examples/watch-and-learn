require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of 5 of their GitHub repositories' do
      WebMock.disable!
      user = create(:user, github_token: ENV['github_key'] )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content("Github")
      expect(page).to have_css('.repos')
      within ".repos" do
        expect(page).to have_link('https://github.com/csvlewis/activerecord-obstacle-course')
        expect(page).to have_link(count: 5)
      end
    end
  end
end
