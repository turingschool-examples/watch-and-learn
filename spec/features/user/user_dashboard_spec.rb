require 'rails_helper'
require 'webmock/rspec'

describe "As a logged in user, on /dashboard" do
  before :each do
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: "790f5a98275d53160a72ff956ad8a4b171635419")
    @user_2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    json_repo_response = File.open("./fixtures/user_repos.json")
    stub_request(:get, "https://api.github.com/user/repos").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'Authorization'=>'token 790f5a98275d53160a72ff956ad8a4b171635419',
       	  'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: json_repo_response, headers: {})

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
  end
end
