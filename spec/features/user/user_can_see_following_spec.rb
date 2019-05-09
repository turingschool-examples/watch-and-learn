require 'rails_helper'

describe 'as a logged in user' do
  before :each do
    json_response = File.open("./fixtures/user_following.json")
    stub_request(:get, "https://api.github.com/user/following").
      to_return(status: 200, body: json_response)
  end

  context 'when I visit my dashboard - in the github section' do
    it 'shows a following section, with my followers handles which link to their profiles' do
      user = create(:user, git_key: ENV["GITHUB_API_KEY"])

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path
      
      expect(page).to have_css('.github')
      expect(page).to have_css('.single_followed')

      within first('.followed') do
        expect(page).to have_css('.profile_link')
      end
    end
  end
end