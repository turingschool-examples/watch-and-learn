require 'rails_helper'

RSpec.describe "Repo", type: :model do
  it "exists" do
    data = {
        "id": 168567322,
        "node_id": "MDEwOlJlcG9zaXRvcnkxNjg1NjczMjI=",
        "name": "activerecord-obstacle-course",
        "full_name": "aprildagonese/activerecord-obstacle-course",
        "private": false,
        "owner": {
            "login": "aprildagonese",
            "id": 41272635,
            "node_id": "MDQ6VXNlcjQxMjcyNjM1",
            "avatar_url": "https://avatars2.githubusercontent.com/u/41272635?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/aprildagonese",
            "html_url": "https://github.com/aprildagonese",
            "followers_url": "https://api.github.com/users/aprildagonese/followers",
            "following_url": "https://api.github.com/users/aprildagonese/following{/other_user}",
            "gists_url": "https://api.github.com/users/aprildagonese/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/aprildagonese/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/aprildagonese/subscriptions",
            "organizations_url": "https://api.github.com/users/aprildagonese/orgs",
            "repos_url": "https://api.github.com/users/aprildagonese/repos",
            "events_url": "https://api.github.com/users/aprildagonese/events{/privacy}",
            "received_events_url": "https://api.github.com/users/aprildagonese/received_events",
            "type": "User",
            "site_admin": false
        } }
    repo = Repo.new(data)

    expect(repo.name).to eq("activerecord-obstacle-course")
  end
end
