require 'rails_helper'

describe 'as a logged in user with a github account' do
  it 'can link accounts to connect with github', :vcr do
    OmniAuth.config.mock_auth[:github] = nil
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({ provider: 'github',
      uid: '123545',
      credentials: { 'token' => ENV['GITHUB_TOKEN'], 'expires'=>false },
      extra: { raw_info:
             { login: 'cheesey_puff',
               html_url: 'https://github.com/babslabs',
               name: 'Huck Finn' } }
              })

    user = create(:user, email: 'user_2@example.com', password: 'password')

    visit '/'

    click_link 'Sign In'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log In'

    expect(current_path).to eq(dashboard_path)

    click_button 'Connect to GitHub'

    expect(user.github_token).to eq(ENV['GITHUB_TOKEN'])
    expect(current_path).to eq(dashboard_path)
  end
end
