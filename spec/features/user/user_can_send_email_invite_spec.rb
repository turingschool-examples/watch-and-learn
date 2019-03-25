require 'rails_helper'

RSpec.describe 'User can send an invite email' do
  describe 'As a registered user' do
    describe 'when I visit my dashboard' do
      before :each do
        @user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        visit dashboard_path
      end
      describe 'and I click on Send an Invite' do
        it 'should have the current path of /invite' do
          click_link "Send an Invite"
          expect(current_path).to eq('/invite')
        end

        describe 'when I fill in the name with a valid github handle' do
          it 'should send an invite to that user and redirect to my dashboard' do
            click_link "Send an Invite"

            fill_in 'github_user[name]', with: 'teresa-m-knowles'
            click_link "Send Invite"

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content("Successfully sent invite!")
          end
        end

        describe 'when I fill in the name with a github handle that does not have an email associated to it' do
          it 'should show an alert that it could not send the invite' do
            click_link "Send an Invite"

            fill_in 'github_user[name]', with: 'akljdfklaj'
            click_link "Send Invite"

            expect(current_path).to eq(dashboard_path)
            expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
          end
        end

      end
    end
  end
end
#
# And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
# And I click on "Send Invite"
# Then I should be on /dashboard
# And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
# Or I should see a message that says "The Github user you selected doesn't have an email address associated with their account."
