require 'rails_helper'

RSpec.describe 'As a user', :vcr do
  before(:each) do
    user = create(:user, token: ENV['MY_TOKEN'], connected?: true, handle: 'lrs8810')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    followers = []
    repos = []
    followings = []

    allow_any_instance_of(UserFacade).to receive(:repos).and_return(repos)
    allow_any_instance_of(UserFacade).to receive(:followers).and_return(followers)
    allow_any_instance_of(UserFacade).to receive(:followings).and_return(followings)

    visit dashboard_path

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')
  end

  it 'I can invite a github user' do

    fill_in :github_handle, with: 'Not-Zorro'

    click_on 'Send Invite'

    expect(current_path).to eq dashboard_path

    expect(page).to have_content('Successfully sent invite!')
  end

  it 'I cannot invite a github user without handle or email' do
    fill_in :github_handle, with: 'Ted4'

    click_on 'Send Invite'

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
