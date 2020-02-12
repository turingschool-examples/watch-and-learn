 require "rails_helper"

 RSpec.describe "as a registered user when I visit /dashboard and click Send Invite" do 
   it "it should redirect be back to /dashboard
        - show me a message that says Successfully sent invite (if email exists)", :vcr do
     email_user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])
     # email_user2 = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'], github_username: "tyladevon", email: "jtobannon@gmail.com")

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(email_user)

     visit "/dashboard"

     click_on "Send an Invite"

     expect(current_path).to eq("/invite")

     fill_in :github_username, with: "jobannon" 

     click_on "Send Invite"

     expect(current_path).to eq("/dashboard")

     expect(page).to have_content("Successfully Sent Invite")
   end

   it "it shows me a messsage The Github user you selected doesn't have an
       email address associated with their account if the user does not have an email address", :vcr do 

     email_user = create(:user, github_token: ENV['GITHUB_ACCESS_TOKEN'])  

     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(email_user)

     visit "/dashboard"

     click_on "Send an Invite"

     expect(current_path).to eq("/invite")

     fill_in :github_username, with: "tyladevon" 

     click_on "Send Invite"

     expect(current_path).to eq("/dashboard")

     expect(page).to have_content("No email present for this user")

   end
 end

