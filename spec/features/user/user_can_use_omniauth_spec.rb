require "rails_helper"

describe 'User logs in through github omniauth' do
  it "shows github info on dashboard" do
    VCR.use_cassette('cassettes/can_see_github_info4') do
      user = User.create!(first_name: 'Deonte',
        last_name: 'Cooper',
        email: '45864171+djc00p@users.noreply.github.com',
        password: 'password')

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path


      OmniAuth.config.test_mode = true

      omniauth_hash = { 'provider' => 'github',
                        'uid' => '12345',
                        'info' => {
                          'nickname' => 'djc00p'
                        },
                        'credentials' => {
                          'token' => ENV['Deonte_token']
                        }}

      OmniAuth.config.add_mock(:github, omniauth_hash)

      click_button 'Connect to Github'

      expect(page).to have_content('Logged into Github')
    end
  end
end
