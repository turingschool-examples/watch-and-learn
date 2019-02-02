require 'rails_helper'

describe 'As a logged in user' do
  it 'can see a link to connect to github' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_link('Connect to Github')
  end
end
