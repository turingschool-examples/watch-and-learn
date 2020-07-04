require 'rails_helper'

describe 'User Dashboard' do
  it 'displays accounts following' do
    user = create(:user, github_token: ENV["GITHUB_ACCESS_TOKEN"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('.github') do
      expect(page).to have_css(".following", count: 0)
    end
  end
end
