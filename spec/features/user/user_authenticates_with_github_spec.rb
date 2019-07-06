# frozen_string_literal: true

require 'rails_helper'

describe 'User logs in with Github' do
  it 'then user can see repo, followers, following info' do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      credentials: {
          token: "Token_1"
        }
      })

      user = create(:user)

      visit '/'

      click_on 'Sign In'
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      expect(current_path).to eq(login_path)
      VCR.use_cassette("features/user/user_sees_followers") do
        fill_in 'session[email]', with: user.email
        fill_in 'session[password]', with: user.password

        click_on 'Log In'

        visit '/dashboard'
      end
      save_and_open_page

      # stub_omniauth
      click_button "Connect to Github"
      user.reload
      expect(current_path).to eq(dashboard_path)



    OmniAuth.config.mock_auth[:github] = nil
  end

  def stub_omniauth
  OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
    provider: 'github',
    credentials: {
        token: ENV['GITHUB_KEY'],
        secret: ENV['GITHUB_SECRET']
      }
    })
  end


  # it 'then user can see repo, followers, following info' do
  #   # VCR.use_cassette("features/user/user_sees_followers") do
  #   WebMock.disable!
  #     user = create(:user)
  #
  #     visit '/'
  #
  #     click_on 'Sign In'
  #
  #     expect(current_path).to eq(login_path)
  #
  #     fill_in 'session[email]', with: user.email
  #     fill_in 'session[password]', with: user.password
  #
  #     click_on 'Log In'
  #
  #     visit '/dashboard'
  #
  #     within '.github' do
  #       within '.followers' do
  #         expect(page).to have_css("#follower-1")
  #       end
  #     end
  #
  #     within '#follower-1' do
  #       expect(page).to have_link("ryanmillergm", href: "https://github.com/ryanmillergm")
  #     end
  # #   end
  # end
end
