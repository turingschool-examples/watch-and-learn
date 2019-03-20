require 'rails_helper'

context 'As a user without a github token' do
  before :each do
    @user = create(:user)
  end

  it 'I see a link on my dashboard to connect to github' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    allow_any_instance_of(User).to receive(:github_token).and_return(nil)

    visit dashboard_path

    expect(page).to have_button 'Connect to GitHub'
    expect(page).to_not have_content 'Following'
    expect(page).to_not have_content 'Followers'
    expect(page).to_not have_content 'battleship'
  end

  it 'I can connect my dashboard to github and see my information' do
    # Login cannot be stubbed
    visit login_path
    fill_in 'session[email]', with: @user.email
    fill_in 'session[password]', with: @user.password
    click_button 'Log In'
    stub_github

    VCR.use_cassette('views/dashboard_github_request') do
      click_button 'Connect to GitHub'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content 'Following'
      expect(page).to have_content 'Follers'
      expect(page).to have_content 'battleship'
    end
  end
end
