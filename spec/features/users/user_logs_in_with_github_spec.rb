require 'rails_helper'

RSpec.describe 'user logs in' do
  scenario 'using Github oauth', :vcr do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    stub_omniauth

    expect(user.token).to be_nil
    expect(user.uid).to be_nil

    visit dashboard_path
    expect(page).to have_button('Connect To Github')

    click_button 'Connect To Github'

    expect(page).to have_content('Personal Repos')
    expect(page).to have_content('Following On Github')
    expect(page).to have_content('Followers On Github')

    user.reload

    expect(user.token).to eq(ENV['GITHUB_TOKEN_LOCAL'])
    expect(user.uid).to be_truthy
  end
end
