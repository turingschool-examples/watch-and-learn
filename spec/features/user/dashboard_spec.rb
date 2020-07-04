require 'rails_helper'

RSpec.describe "As a user" do
    describe "when I visit /dashboard" do
        describe "I see a link to login with OAuth" do 
            it "allows me to login through Github" do 
                user = create(:user)
                expect(page).to have_content()
            end
        end  
        
        describe "when I have a github token stored in the db" do

            it "shows a section for 'Github' with a list of 5 repos underneath" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)  
        
                visit '/dashboard'

                expect(page).to have_content("Github Repos:") 
                expect(page).to have_css("a.repos", count: 5)
            end

            it "it shows a section for followers within the Github section of page" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]

                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) 
                
                visit '/dashboard' 

                expect(page).to have_content("Followers")
                expect(page).to have_css("a.followers", count: 5)
            end

            it "it shows a section for people user is following within the Github section of page" do
                user = create(:user)
                user2 = create(:user)
                user.token = ENV["GITHUB_TOKEN"]
                user2.token = ENV["JESSE_GITHUB_TOKEN"]

                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user) 
                
                visit '/dashboard' 

                expect(page).to have_content("Following")
                expect(page).to have_css("a.following", count: 3)
            end
        end

        describe "when I DO NOT have a github token stored in the db" do

            it "it doesn't show Github section" do
                user = create(:user)
                
                allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)  
        
                visit '/dashboard'

                expect(page).to_not have_content("Github Repos:") 
                expect(page).to_not have_css("a.repos", count: 5)
            end
        
        end

    end
end
# As a user
# When I visit /dashboard
# Then I should see a link that is styled like a button that says "Connect to Github"
# And when I click on "Connect to Github"
# Then I should go through the OAuth process
# And I should be redirected to /dashboard
# And I should see all of the content from the previous Github stories (repos, followers, and following)