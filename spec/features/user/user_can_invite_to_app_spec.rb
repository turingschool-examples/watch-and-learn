require 'rails_helper'

RSpec.describe 'User can send an email invite to the application' do
  describe 'As a logged in user, my dashboard' do
    before :each do
      @user = create(:user, uid: 12345)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      stub_user_1_dashboard

      ActionMailer::Base.deliveries = []

    end
    describe 'if I am connected to Github' do
      before :each do
        create(:github_token, user: @user, token: ENV['USER_1_GITHUB_TOKEN'])
      end

      it 'has a Send an Invite button' do

        visit dashboard_path

        click_button("Send an Invite")

        expect(current_path).to eq(invite_path)

      end

      describe 'When I click on send an Invite'  do
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

            fill_in 'handle', with: 'teresa-m-knowles'

            stub_get_json("https://api.github.com/users/teresa-m-knowles", "user_1_github_get_user.json")

            click_button("Send Invite")

            expect(page).to have_content("Successfully sent invite!")

            email = ActionMailer::Base.deliveries.last
            email_body = email.part.first.body.raw_source

            expect(email.subject).to eq("#{@user.first_name} wants to invite you to Brownfield of Dreams.")

            expect(email_body).to have_link("Register", href: "http://localhost/register")
            expect(ActionMailer::Base.deliveries.count).to eq(1)

          end

          it 'redirects me to my dashboard and I see a success message' do
            visit dashboard_path

            click_button("Send an Invite")

            expect(current_path).to eq('/invite')

            fill_in 'handle', with: 'teresa-m-knowles'

            stub_get_json("https://api.github.com/users/teresa-m-knowles", "user_1_github_get_user.json")

            click_button("Send Invite")

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content("Successfully sent invite!")

            expect(ActionMailer::Base.deliveries.count).to eq(1)

          end

          it 'should not allow me to send an invite to anyone already registered(including myself)' do
            @user.update(uid: 123456)

            user_2 = create(:user, uid: 45)
            create(:github_token, user: user_2, token: ENV['USER_2_GITHUB_TOKEN'])

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

            stub_user_2_dashboard

            visit dashboard_path

            click_button("Send an Invite")

            expect(current_path).to eq('/invite')

            fill_in 'handle', with: 'teresa-m-knowles'

            stub_get_json("https://api.github.com/users/teresa-m-knowles", "user_1_github_get_user.json")

            click_button("Send Invite")

            expect(page).to have_content("Error: That user is already a member of Brownfield of Dreams")

          end
        end

        describe 'if there is no email associated to that handle' do
          it 'should redirect me to my dashboard and I see an error message' do
            visit dashboard_path

            click_button("Send an Invite")

            expect(current_path).to eq('/invite')

            fill_in 'handle', with: 'wrong-handle'

            stub_get_json("https://api.github.com/users/wrong-handle", "wrong_username.json")

            click_button("Send Invite")


            expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")

            expect(ActionMailer::Base.deliveries.count).to eq(0)

            expect(current_path).to eq(dashboard_path)

          end
        end

      end
    end

    describe 'if I am NOT connected to Github' do
      it 'does not have a Send an Invite button' do
        visit dashboard_path

        expect(page).to_not have_button("Send an Invite")
      end
    end

  end
end
