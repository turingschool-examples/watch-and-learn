# frozen_string_literal: true

require 'rails_helper'

describe 'as a registered user' do
  context 'I should be active' do
    it 'should be able to send invite to friend' do
      VCR.use_cassette('mailer/send_invitation') do
        earl = User.create!(first_name: 'Earl',
                            last_name: 'Stephens',
                            email: 'sethreader@hotmail.com',
                            password: 'password',
                            username: 'earl-stephens',
                            github_token: ENV['token'],
                            status: 'active')

        username = 'djc00p'

        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(earl)

        visit dashboard_path

        click_link 'Send an Invite'

        expect(current_path).to eq(invite_path)
        # save_and_open_page
        fill_in 'Github Handle', with: username.to_s

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content('Successfully sent invite!')
      end
    end

    it 'should not be able to send invite to friend' do
      VCR.use_cassette('mailer/send_invitation2') do
        earl = User.create!(first_name: 'Earl',
                            last_name: 'Stephens',
                            email: 'sethreader@hotmail.com',
                            password: 'password',
                            username: 'earl-stephens',
                            github_token: ENV['token'],
                            status: 'active')

        username = 'pschlatt'

        allow_any_instance_of(ApplicationController)
          .to receive(:current_user)
          .and_return(earl)

        visit dashboard_path

        click_link 'Send an Invite'

        expect(current_path).to eq(invite_path)
        # save_and_open_page
        fill_in 'Github Handle', with: username.to_s

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)
        expect(page).to have_content("The Github user you've selected doesn't have an email address associated with their account.")
      end
    end
  end
end
