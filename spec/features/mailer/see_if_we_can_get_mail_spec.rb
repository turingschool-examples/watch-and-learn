# frozen_string_literal: true

require 'rails_helper'

describe 'as an unregistered user' do
  VCR.use_cassette('mailer/see_if_we_can_get_mail_spec2') do
    it 'can recieve activation email' do
      visit root_path

      click_on 'Register'

      fill_in 'Email', with: 'doente.cooper@gmail.com'
      fill_in 'First name', with: 'Deonte'
      fill_in 'Last name', with: 'Cooper'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'

      click_button 'Create Account'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Logged in as Deonte')
      expect(page).to have_content('This account has not yet been activated. Please check your email.')
    end
  end

  it 'should recieve email to activation' do
    VCR.use_cassette('mailer/see_if_we_can_get_mail_spec2') do
      user = User.create!(first_name: 'Earl',
                          last_name: 'Stephens',
                          email: 'sethreader@hotmail.com',
                          password: 'password',
                          username: 'earl-stephens',
                          github_token: ENV['token'])

      expect(user.status).to eq('inactive')

      visit "/activation?email=#{user.email}"
      user.reload

      expect(current_path).to eq(thankyou_path)
      expect(page).to have_content('Thank you! Your account is now activated.')

      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(user)

      visit dashboard_path

      expect(page).to have_content('Status: Active')
    end
  end
end
