require 'rails_helper'

describe 'As a registered user' do
  describe 'when I visit the dashboard' do
    it 'can click a link to Send an Invite' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit dashboard_path
      
      click_link('Send an Invite')
      
      expect(current_path).to eq(invite_path)
    end
    it 'can see a form to send an invite' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit invite_path
      
      expect(page).to have_field('Github Handle')
      expect(page).to have_button('Send Invite')
    end
    it 'can send an invite', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit invite_path
      
      fill_in 'Github Handle', with: 'octocat'
      click_on 'Send Invite'
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Successfully sent invite!')
    end
    it 'can not send an invite if the user does not have email associated with Github', :vcr do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit invite_path
      
      fill_in 'Github Handle', with: ENV['GITHUB_HANDLE']
      click_on 'Send Invite'
      
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end
end