require 'rails_helper'

RSpec.describe 'User can send an email invite to the application' do
  describe 'As a logged in user, in my dashboard' do
    before :each do
      @user = create(:user)
      create(:github_token, user: @user, token: ENV['USER_1_GITHUB_TOKEN'])

      attributes = {
        login: "jamisonordway",
        html_url: "https://github.com/jamisonordway",
        email: "jamison@email.com",
        id: "12345"
      }

      @github_user = GithubUser.new(attributes)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      stub_user_1_dashboard

    end
    it 'has a Send an Invite button' do

        visit dashboard_path

        click_button("Send an Invite")

        expect(current_path).to eq(invite_path)

    end

    describe 'When I click on send an Invite' do
      it 'my path is now /invite' do

        visit dashboard_path

        click_button("Send an Invite")

        expect(current_path).to eq('/invite')

      end

      describe 'if I enter a valid github handle' do
        it 'should send an email to that github user inviting them to the app' do
          visit dashboard_path

          click_button("Send an Invite")

          expect(current_path).to eq('/invite')

          save_and_open_page
          fill_in 'handle', with: 'nagerz'
        end

        it 'redirects me to my dashboard and I see a success message' do
        end
      end

      describe 'if there is no email associated to that handle' do
        it 'should redirect me to my dashboard and I see an error message' do
        end
      end

    end
  end
end
