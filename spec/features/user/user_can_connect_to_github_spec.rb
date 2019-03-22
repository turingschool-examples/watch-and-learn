require 'rails_helper'

RSpec.describe 'A logged in User can connect their Github account' do

  describe 'As a logged in user' do

    context 'that has NOT connected their github account' do

      before :each do
        @user_1 = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
      end

      describe 'in my dashboard' do
        it 'should show a connect to github button' do
          visit '/dashboard'
          expect(page).to have_button('Connect to Github')
        end

        it 'should not show my repositories, following and followers' do
          visit '/dashboard'

          expect(page).to_not have_css('.repositories')
          expect(page).to_not have_css('.followers')
          expect(page).to_not have_css('.users_followed')
        end
      end

      describe 'if connect to github with good credentials' do
        it 'I should have a user uid and see a flash success message' do
          visit '/dashboard'
          click_on "Connect to Github"

          uid = OmniAuth.config.mock_auth[:github][:uid]

          expect(@user_1.uid).to eq(uid)
          expect(page).to have_content("Your Github account is now linked.")

          expect(page).to have_css('.repositories')
          expect(page).to have_css('.followers')
          expect(page).to have_css('.users_followed')
        end
      end

      describe 'if I try to connect a github account already associated to a user' do
        it 'should not let me connect and I should see an error message' do
          create(:user, uid: '13354855')

          visit dashboard_path

          click_on "Connect to Github"

          expect(page).to have_content("That Github account is already in use.")
          expect(page).to_not have_css('.repositories')
          expect(page).to_not have_css('.followers')
          expect(page).to_not have_css('.users_followed')

          expect(current_path).to eq(dashboard_path)
        end
      end

    end

    context 'that has already connected their github account' do
      before :each do
        @user_2 = create(:user, uid: '13354855')
        request = OmniAuth.config.mock_auth[:github]
        token = request[:credentials][:token]
        GithubToken.create(token: token, user: @user_2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      end
      describe 'in my dashboard' do
        it 'should not show a connect to github button' do
          visit '/dashboard'

          expect(page).to_not have_button("Connect to Github")
        end

        it 'should show my repositories, following and followers' do
          visit '/dashboard'

          expect(page).to have_css('.repositories')
          expect(page).to have_css('.followers')
          expect(page).to have_css('.users_followed')

        end

      end
    end

  end
end
