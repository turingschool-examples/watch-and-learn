require 'rails_helper'

describe 'as a logged in user who has connected with github' do
 it 'can add registered users as friends', :vcr do
   user_1 = create(:user, access_token: ENV['GITHUB_TOKEN_KEY'])
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

   user_2 = create(:user, access_token: ENV['TEST_KEY'], github_login: 'jtaylor522')


   visit dashboard_path
   expect(page).to_not have_content("Your Friends")

   within '#jtaylor522' do
     expect(page).to have_button("Add as Friend")
     click_button("Add as Friend")
     expect(current_path).to eq(dashboard_path)
   end

   within '.friends' do
     expect(page).to have_content("Your Friends")
     expect(page).to have_content("jtaylor522")
   end

 end
end
