require 'rails_helper'

describe 'Email Invites' do
  context 'as a registered user on dashboard page' do
    context "clicking 'Send an Invite'" do
      before :each do
        json_response = File.open('./spec/fixtures/github_user_email.json')
        stub_request(:get, "https://api.github.com/users/stoic-plus").to_return(status: 200, body: json_response)

        json_response = File.open('./spec/fixtures/github_user_no_email.json')
        stub_request(:get, "https://api.github.com/users/NickLindeberg").to_return(status: 200, body: json_response)

        @user = create(:user, first_name: 'Jon', last_name: 'Doe')
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      end
      it 'redirects to /invite' do
        visit dashboard_path
        click_button "Send an Invite"
        expect(current_path).to eq(new_invite_path)
      end
      context "with valid handle in 'Github Handle'" do
        it 'redirects to dashboard' do
          visit new_invite_path
          fill_in "Github Handle", with: "stoic-plus"
          click_button "Send Invite"
          expect(current_path).to eq(dashboard_path)
        end
        it 'shows success message if user has email on github' do
          visit new_invite_path
          fill_in "Github Handle", with: "stoic-plus"
          click_button "Send Invite"
          expect(page).to have_content("Successfully sent invite!")
        end
        it 'shows explanation message if user does not have email on github' do
          visit new_invite_path
          fill_in "Github Handle", with: "NickLindeberg"
          click_button "Send Invite"
          expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
        end
        it 'sends email in valid format if user has email' do
          visit new_invite_path
          fill_in "Github Handle", with: "stoic-plus"
          click_button "Send Invite"

          open_email('ricardoledesmadev@gmail.com')
          expect(current_email).to have_content("Hello stoic-plus,")
          expect(current_email).to have_content("Jon, Doe has invited you to join Brownfield of Dreams. You can create an account here")
          expect(current_email).to have_link("here", href: "http://localhost:3000/register")
        end
      end
    end
  end
end
