require 'rails_helper'
require 'webmock/rspec'

describe "As a logged in user, on /dashboard" do
  before :each do
    @user = User.create(email: "john@gmail.com", first_name: "John", last_name: "smith", token: ENV["GITHUB_API_KEY"])

    @user_2 = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

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

#     [
#     {
#         "login": "Loomus",
#         "id": 44850604,
#         "node_id": "MDQ6VXNlcjQ0ODUwNjA0",
#         "avatar_url": "https://avatars0.githubusercontent.com/u/44850604?v=4",
#         "gravatar_id": "",
#         "url": "https://api.github.com/users/Loomus",
#         "html_url": "https://github.com/Loomus",
#         "followers_url": "https://api.github.com/users/Loomus/followers",
#         "following_url": "https://api.github.com/users/Loomus/following{/other_user}",
#         "gists_url": "https://api.github.com/users/Loomus/gists{/gist_id}",
#         "starred_url": "https://api.github.com/users/Loomus/starred{/owner}{/repo}",
#         "subscriptions_url": "https://api.github.com/users/Loomus/subscriptions",
#         "organizations_url": "https://api.github.com/users/Loomus/orgs",
#         "repos_url": "https://api.github.com/users/Loomus/repos",
#         "events_url": "https://api.github.com/users/Loomus/events{/privacy}",
#         "received_events_url": "https://api.github.com/users/Loomus/received_events",
#         "type": "User",
#         "site_admin": false
#     },
#     {
#         "login": "ryanmillergm",
#         "id": 42855291,
#         "node_id": "MDQ6VXNlcjQyODU1Mjkx",
#         "avatar_url": "https://avatars0.githubusercontent.com/u/42855291?v=4",
#         "gravatar_id": "",
#         "url": "https://api.github.com/users/ryanmillergm",
#         "html_url": "https://github.com/ryanmillergm",
#         "followers_url": "https://api.github.com/users/ryanmillergm/followers",
#         "following_url": "https://api.github.com/users/ryanmillergm/following{/other_user}",
#         "gists_url": "https://api.github.com/users/ryanmillergm/gists{/gist_id}",
#         "starred_url": "https://api.github.com/users/ryanmillergm/starred{/owner}{/repo}",
#         "subscriptions_url": "https://api.github.com/users/ryanmillergm/subscriptions",
#         "organizations_url": "https://api.github.com/users/ryanmillergm/orgs",
#         "repos_url": "https://api.github.com/users/ryanmillergm/repos",
#         "events_url": "https://api.github.com/users/ryanmillergm/events{/privacy}",
#         "received_events_url": "https://api.github.com/users/ryanmillergm/received_events",
#         "type": "User",
#         "site_admin": false
#     },
#     {
#         "login": "earl-stephens",
#         "id": 34906415,
#         "node_id": "MDQ6VXNlcjM0OTA2NDE1",
#         "avatar_url": "https://avatars1.githubusercontent.com/u/34906415?v=4",
#         "gravatar_id": "",
#         "url": "https://api.github.com/users/earl-stephens",
#         "html_url": "https://github.com/earl-stephens",
#         "followers_url": "https://api.github.com/users/earl-stephens/followers",
#         "following_url": "https://api.github.com/users/earl-stephens/following{/other_user}",
#         "gists_url": "https://api.github.com/users/earl-stephens/gists{/gist_id}",
#         "starred_url": "https://api.github.com/users/earl-stephens/starred{/owner}{/repo}",
#         "subscriptions_url": "https://api.github.com/users/earl-stephens/subscriptions",
#         "organizations_url": "https://api.github.com/users/earl-stephens/orgs",
#         "repos_url": "https://api.github.com/users/earl-stephens/repos",
#         "events_url": "https://api.github.com/users/earl-stephens/events{/privacy}",
#         "received_events_url": "https://api.github.com/users/earl-stephens/received_events",
#         "type": "User",
#         "site_admin": false
#     }

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

# And under that section I should see another section titled "Followers"
# And I should see list of all followers with their handles linking to their Github profile
