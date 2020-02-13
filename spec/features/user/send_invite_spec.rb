# frozen_string_literal: true

require 'rails_helper'

describe '/dashboard page' do
  it 'send invitation' do
    VCR.use_cassette('send_invitation_happy') do
      user = create(:user, github_id: '29346170', token: ENV['GITHUB_ACCESS_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/dashboard'

      click_on 'Send Email Invite'

      expect(current_path).to eq('/invite')

      fill_in :github_handle, with: 'jmejia'
      click_on('Send Email Invite')

      expect(current_path).to eq('/dashboard')
      expect(page).to have_content('Successfully sent invite!')
    end
  end

  it 'send invitation - SAD' do
    user = create(:user, github_id: '29346170', token: ENV['GITHUB_ACCESS_TOKEN'])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette('send_invitation_sad') do
      visit '/dashboard'

      click_on 'Send Email Invite'

      expect(current_path).to eq('/invite')

      click_on 'Send Email Invite'

      fill_in :github_handle, with: 'hale4027'
      click_on('Send Email Invite')

      expect(current_path).to eq('/invite')
      expect(page).to have_content('Oops, something went wrong (probably due to email not being public).')
    end
  end
end
