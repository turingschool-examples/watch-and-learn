require 'rails_helper'

describe 'as a logged in user' do
  it 'should see a section for Github with a list of 5 repositories linking to github' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to have_content("Github")

    within('.github') do
      # expect(page).to have_link('repo_name')
      expect(page).to have_css(".repository", count: 5)
    end
  end
end
