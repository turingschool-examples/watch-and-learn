require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  before :each do 
    @followers = [
      {
          "login": "TheCraftedGem",
          "id": 38091448,
          "node_id": "MDQ6VXNlcjM4MDkxNDQ4",
          "avatar_url": "https://avatars0.githubusercontent.com/u/38091448?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/TheCraftedGem",
          "html_url": "https://github.com/TheCraftedGem",
          "followers_url": "https://api.github.com/users/TheCraftedGem/followers",
          "following_url": "https://api.github.com/users/TheCraftedGem/following{/other_user}",
          "gists_url": "https://api.github.com/users/TheCraftedGem/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/TheCraftedGem/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/TheCraftedGem/subscriptions",
          "organizations_url": "https://api.github.com/users/TheCraftedGem/orgs",
          "repos_url": "https://api.github.com/users/TheCraftedGem/repos",
          "events_url": "https://api.github.com/users/TheCraftedGem/events{/privacy}",
          "received_events_url": "https://api.github.com/users/TheCraftedGem/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "leiyakenney",
          "id": 45922590,
          "node_id": "MDQ6VXNlcjQ1OTIyNTkw",
          "avatar_url": "https://avatars3.githubusercontent.com/u/45922590?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/leiyakenney",
          "html_url": "https://github.com/leiyakenney",
          "followers_url": "https://api.github.com/users/leiyakenney/followers",
          "following_url": "https://api.github.com/users/leiyakenney/following{/other_user}",
          "gists_url": "https://api.github.com/users/leiyakenney/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/leiyakenney/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/leiyakenney/subscriptions",
          "organizations_url": "https://api.github.com/users/leiyakenney/orgs",
          "repos_url": "https://api.github.com/users/leiyakenney/repos",
          "events_url": "https://api.github.com/users/leiyakenney/events{/privacy}",
          "received_events_url": "https://api.github.com/users/leiyakenney/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "tylorschafer",
          "id": 3358870,
          "node_id": "MDQ6VXNlcjMzNTg4NzA=",
          "avatar_url": "https://avatars0.githubusercontent.com/u/3358870?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/tylorschafer",
          "html_url": "https://github.com/tylorschafer",
          "followers_url": "https://api.github.com/users/tylorschafer/followers",
          "following_url": "https://api.github.com/users/tylorschafer/following{/other_user}",
          "gists_url": "https://api.github.com/users/tylorschafer/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/tylorschafer/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/tylorschafer/subscriptions",
          "organizations_url": "https://api.github.com/users/tylorschafer/orgs",
          "repos_url": "https://api.github.com/users/tylorschafer/repos",
          "events_url": "https://api.github.com/users/tylorschafer/events{/privacy}",
          "received_events_url": "https://api.github.com/users/tylorschafer/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "StarPerfect",
          "id": 47605558,
          "node_id": "MDQ6VXNlcjQ3NjA1NTU4",
          "avatar_url": "https://avatars2.githubusercontent.com/u/47605558?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/StarPerfect",
          "html_url": "https://github.com/StarPerfect",
          "followers_url": "https://api.github.com/users/StarPerfect/followers",
          "following_url": "https://api.github.com/users/StarPerfect/following{/other_user}",
          "gists_url": "https://api.github.com/users/StarPerfect/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/StarPerfect/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/StarPerfect/subscriptions",
          "organizations_url": "https://api.github.com/users/StarPerfect/orgs",
          "repos_url": "https://api.github.com/users/StarPerfect/repos",
          "events_url": "https://api.github.com/users/StarPerfect/events{/privacy}",
          "received_events_url": "https://api.github.com/users/StarPerfect/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "MackHalliday",
          "id": 16658577,
          "node_id": "MDQ6VXNlcjE2NjU4NTc3",
          "avatar_url": "https://avatars2.githubusercontent.com/u/16658577?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/MackHalliday",
          "html_url": "https://github.com/MackHalliday",
          "followers_url": "https://api.github.com/users/MackHalliday/followers",
          "following_url": "https://api.github.com/users/MackHalliday/following{/other_user}",
          "gists_url": "https://api.github.com/users/MackHalliday/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/MackHalliday/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/MackHalliday/subscriptions",
          "organizations_url": "https://api.github.com/users/MackHalliday/orgs",
          "repos_url": "https://api.github.com/users/MackHalliday/repos",
          "events_url": "https://api.github.com/users/MackHalliday/events{/privacy}",
          "received_events_url": "https://api.github.com/users/MackHalliday/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "evettetelyas",
          "id": 50186721,
          "node_id": "MDQ6VXNlcjUwMTg2NzIx",
          "avatar_url": "https://avatars0.githubusercontent.com/u/50186721?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/evettetelyas",
          "html_url": "https://github.com/evettetelyas",
          "followers_url": "https://api.github.com/users/evettetelyas/followers",
          "following_url": "https://api.github.com/users/evettetelyas/following{/other_user}",
          "gists_url": "https://api.github.com/users/evettetelyas/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/evettetelyas/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/evettetelyas/subscriptions",
          "organizations_url": "https://api.github.com/users/evettetelyas/orgs",
          "repos_url": "https://api.github.com/users/evettetelyas/repos",
          "events_url": "https://api.github.com/users/evettetelyas/events{/privacy}",
          "received_events_url": "https://api.github.com/users/evettetelyas/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "rlew421",
          "id": 48839191,
          "node_id": "MDQ6VXNlcjQ4ODM5MTkx",
          "avatar_url": "https://avatars0.githubusercontent.com/u/48839191?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/rlew421",
          "html_url": "https://github.com/rlew421",
          "followers_url": "https://api.github.com/users/rlew421/followers",
          "following_url": "https://api.github.com/users/rlew421/following{/other_user}",
          "gists_url": "https://api.github.com/users/rlew421/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/rlew421/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/rlew421/subscriptions",
          "organizations_url": "https://api.github.com/users/rlew421/orgs",
          "repos_url": "https://api.github.com/users/rlew421/repos",
          "events_url": "https://api.github.com/users/rlew421/events{/privacy}",
          "received_events_url": "https://api.github.com/users/rlew421/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "jobannon",
          "id": 16090626,
          "node_id": "MDQ6VXNlcjE2MDkwNjI2",
          "avatar_url": "https://avatars2.githubusercontent.com/u/16090626?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/jobannon",
          "html_url": "https://github.com/jobannon",
          "followers_url": "https://api.github.com/users/jobannon/followers",
          "following_url": "https://api.github.com/users/jobannon/following{/other_user}",
          "gists_url": "https://api.github.com/users/jobannon/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/jobannon/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/jobannon/subscriptions",
          "organizations_url": "https://api.github.com/users/jobannon/orgs",
          "repos_url": "https://api.github.com/users/jobannon/repos",
          "events_url": "https://api.github.com/users/jobannon/events{/privacy}",
          "received_events_url": "https://api.github.com/users/jobannon/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "mcat56",
          "id": 51488670,
          "node_id": "MDQ6VXNlcjUxNDg4Njcw",
          "avatar_url": "https://avatars1.githubusercontent.com/u/51488670?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/mcat56",
          "html_url": "https://github.com/mcat56",
          "followers_url": "https://api.github.com/users/mcat56/followers",
          "following_url": "https://api.github.com/users/mcat56/following{/other_user}",
          "gists_url": "https://api.github.com/users/mcat56/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/mcat56/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/mcat56/subscriptions",
          "organizations_url": "https://api.github.com/users/mcat56/orgs",
          "repos_url": "https://api.github.com/users/mcat56/repos",
          "events_url": "https://api.github.com/users/mcat56/events{/privacy}",
          "received_events_url": "https://api.github.com/users/mcat56/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "wrenisit",
          "id": 49083187,
          "node_id": "MDQ6VXNlcjQ5MDgzMTg3",
          "avatar_url": "https://avatars0.githubusercontent.com/u/49083187?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/wrenisit",
          "html_url": "https://github.com/wrenisit",
          "followers_url": "https://api.github.com/users/wrenisit/followers",
          "following_url": "https://api.github.com/users/wrenisit/following{/other_user}",
          "gists_url": "https://api.github.com/users/wrenisit/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/wrenisit/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/wrenisit/subscriptions",
          "organizations_url": "https://api.github.com/users/wrenisit/orgs",
          "repos_url": "https://api.github.com/users/wrenisit/repos",
          "events_url": "https://api.github.com/users/wrenisit/events{/privacy}",
          "received_events_url": "https://api.github.com/users/wrenisit/received_events",
          "type": "User",
          "site_admin": false
      },
      {
          "login": "jfangonilo",
          "id": 53122061,
          "node_id": "MDQ6VXNlcjUzMTIyMDYx",
          "avatar_url": "https://avatars1.githubusercontent.com/u/53122061?v=4",
          "gravatar_id": "",
          "url": "https://api.github.com/users/jfangonilo",
          "html_url": "https://github.com/jfangonilo",
          "followers_url": "https://api.github.com/users/jfangonilo/followers",
          "following_url": "https://api.github.com/users/jfangonilo/following{/other_user}",
          "gists_url": "https://api.github.com/users/jfangonilo/gists{/gist_id}",
          "starred_url": "https://api.github.com/users/jfangonilo/starred{/owner}{/repo}",
          "subscriptions_url": "https://api.github.com/users/jfangonilo/subscriptions",
          "organizations_url": "https://api.github.com/users/jfangonilo/orgs",
          "repos_url": "https://api.github.com/users/jfangonilo/repos",
          "events_url": "https://api.github.com/users/jfangonilo/events{/privacy}",
          "received_events_url": "https://api.github.com/users/jfangonilo/received_events",
          "type": "User",
          "site_admin": false
      }
  ]
  end 
  xscenario "Can view followers on dash board"  do 
    stub_request(:get, "https://api.github.com/user/followers").
    to_return(status: 200, body: @followers)

    user = create(:user, github_token: ENV["DANNY_GH_TOKEN"])

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    
    visit '/dashboard'
    # user.reload
# save_and_open_page
    within "#followers" do
        expect(page).to have_css(".follower", count: 11)
        expect(page).to have_content("Github Followers")
        expect(page).to have_link("TheCraftedGem", href: "https://github.com/TheCraftedGem")
        expect(page).to have_link("leiyakenney", href:"https://github.com/leiyakenney")
    end
  end   
end
