require 'rails_helper'
require 'webmock/rspec'

describe "As a logged in user, on /dashboard" do
  before :each do
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: ENV['GITHUB_API_KEY'])

    @user_2 = create(:user)

    json_repo_response = File.open("./fixtures/user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v0.15.4'
          })
          .to_return(status: 200, body: json_repo_response, headers: {})


      json_followers_response = File.open("./fixtures/user_followers.json")
      stub_request(:get, "https://api.github.com/user/followers").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=>"token #{@user.token}",
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: json_followers_response, headers: {})

    json_following_response = File.open("./fixtures/user_following.json")
      stub_request(:get, "https://api.github.com/user/following").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: json_following_response, headers: {})
           allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit dashboard_path

  end
  context "There is a section for 'Github'" do
    it "Displays list of repository names each as links to their repo" do

      visit dashboard_path

      within(".github") do
        within(".github-repos") do
          expect(page).to have_css(".repo", count: 5)
          expect(page).to have_link("1901-mod2unes")
          expect(page).to have_link("2win_playlist")
          expect(page).to have_link("a-perilous-journey")
          expect(page).to have_link("activerecord-obstacle-course")
          expect(page).to have_link("activerecord-obstacle-course-1")
        end
      end
    end

    it "User without token does not see github section" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit dashboard_path

      expect(page).to_not have_css(".github")
    end

    it "Displays list of github users the current user follows, handels are links to profile" do
      within(".github") do
        within(".github-following") do
          expect(page).to have_link("n-flint")
          expect(page).to have_link("earl-stephens")
          expect(page).to have_link("ryanmillergm")
          expect(page).to have_link("Loomus")
        end
      end
    end
  

    context "Under the github section" do
      it "There is a section called followers" do

        visit dashboard_path

        within(".github") do
          within(".github-followers") do
            expect(page).to have_css(".follower", count: 3)
            expect(page).to have_link("Loomus")
            expect(page).to have_link("ryanmillergm")
            expect(page).to have_link("earl-stephens")
          end
        end
      end
    end
  end
end
