require 'rails_helper'

describe 'Email Invites' do
  context 'as a registered user on dashboard page' do
    context "clicking 'Send an Invite'" do
      before :each do
        json_response = File.open('./spec/fixtures/github_user_email.json')
        stub_request(:get, "https://api.github.com/users/stoic-plus").to_return(status: 200, body: json_response)

        json_response = File.open('./spec/fixtures/github_user_no_email.json')
        stub_request(:get, "https://api.github.com/users/NickLindeberg").to_return(status: 200, body: json_response)

        @user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end
      it 'redirects to /invite' do
        click_button "Send an Invite"
        expect(current_path).to eq(invite_path)
      end
      context "with valid handle in 'Github Handle'" do
        xit 'redirects to dashboard' do
          visit invite_path
          fill_in "Github Handle", with: "stoic-plus"
          click_button "Send an Invite"
          expect(current_path).to eq(dashboard_path)
        end
        xit 'shows success message if user has email on github' do
          visit invite_path
          fill_in "Github Handle", with: "stoic-plus"
          click_button "Send an Invite"
          expect(page).to have_content("Successfully sent invite!")
        end
        xit 'shows explanation message if user does not have email on github' do
          visit invite_path
          fill_in "Github Handle", with: "NickLindeberg"
          click_button "Send an Invite"
          expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
        end
      end
    end
  end
end
