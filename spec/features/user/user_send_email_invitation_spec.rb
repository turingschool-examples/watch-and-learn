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
  end
end