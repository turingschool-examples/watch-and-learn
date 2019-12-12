require 'rails_helper'

RSpec.describe 'A registered user' do
  it 'can add as a friend a github following who has an account', :vcr do
    user = create(:user, activated?: true, github_token: ENV['GITHUB_TOKEN_1'])
    user_2 = create(:user, handle: 'freeheeling', activated?: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('.github-following') do
      click_button('Add as Friend')
    end

    expect(page).to have_content('Added Friend!')

    user.reload

    visit dashboard_path

    within('.github-following') do
      expect(page).to_not have_button('Add as Friend')
    end
  end

  it 'can add as a friend a github follower who has an account', :vcr do
    user = create(:user, activated?: true, github_token: ENV['GITHUB_TOKEN_1'])
    user_2 = create(:user, handle: 'freeheeling', activated?: true)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('.github-followers') do
      click_button('Add as Friend')
    end

    expect(page).to have_content('Added Friend!')

    user.reload

    visit dashboard_path

    within('.github-followers') do
      expect(page).to_not have_button('Add as Friend')
    end
  end

  it 'cannot add a github follower/following as a friend if the user does not have an account', :vcr do
    user = create(:user, activated?: true, github_token: ENV['GITHUB_TOKEN_1'])
    user_2 = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    within('.github-followers') do
      expect(page).to_not have_button('Add as Friend')
    end
  end
end
