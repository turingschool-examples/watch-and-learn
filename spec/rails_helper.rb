require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
end

OmniAuth.config.test_mode = true

omniauth_hash = {
"provider"=>"github",
 "uid"=>"13354855",
 "info"=>
  {"nickname"=>"teresa-m-knowles",
   "email"=>nil,
   "name"=>"Teresa M Knowles",
   "image"=>"https://avatars0.githubusercontent.com/u/13354855?v=4",
   "urls"=>{"GitHub"=>"https://github.com/teresa-m-knowles", "Blog"=>""}},
 "credentials"=>{"token"=>"bc15f386df89daad35ab23549a554fccfaafd4e2", "expires"=>false},
 "extra"=>
  {"raw_info"=>
    {"login"=>"teresa-m-knowles",
     "id"=>13354855,
     "node_id"=>"MDQ6VXNlcjEzMzU0ODU1",
     "avatar_url"=>"https://avatars0.githubusercontent.com/u/13354855?v=4",
     "gravatar_id"=>"",
     "url"=>"https://api.github.com/users/teresa-m-knowles",
     "html_url"=>"https://github.com/teresa-m-knowles",
     "followers_url"=>"https://api.github.com/users/teresa-m-knowles/followers",
     "following_url"=>"https://api.github.com/users/teresa-m-knowles/following{/other_user}",
     "gists_url"=>"https://api.github.com/users/teresa-m-knowles/gists{/gist_id}",
     "starred_url"=>"https://api.github.com/users/teresa-m-knowles/starred{/owner}{/repo}",
     "subscriptions_url"=>"https://api.github.com/users/teresa-m-knowles/subscriptions",
     "organizations_url"=>"https://api.github.com/users/teresa-m-knowles/orgs",
     "repos_url"=>"https://api.github.com/users/teresa-m-knowles/repos",
     "events_url"=>"https://api.github.com/users/teresa-m-knowles/events{/privacy}",
     "received_events_url"=>"https://api.github.com/users/teresa-m-knowles/received_events",
     "type"=>"User",
     "site_admin"=>false,
     "name"=>"Teresa M Knowles",
     "company"=>nil,
     "blog"=>"",
     "location"=>nil,
     "email"=>nil,
     "hireable"=>true,
     "bio"=>nil,
     "public_repos"=>37,
     "public_gists"=>7,
     "followers"=>9,
     "following"=>12,
     "created_at"=>"2015-07-15T19:08:28Z",
     "updated_at"=>"2019-03-22T02:39:27Z"},
   "all_emails"=>[]}
 }


OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(omniauth_hash)
# OmniAuth.config.mock_auth[:github] = :invalid_credentials


OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

def stub_get_json(url, filename)
  json_response = File.open("./fixtures/#{filename}")

  stub_request(:get, url).
    to_return(status: 200, body: json_response)
end

def stub_user_1_dashboard
  filename1 = 'user_1_github_repos.json'
  url1 = "https://api.github.com/user/repos?type=owner"
  stub_get_json(url1, filename1)

  filename2 = 'user_1_github_followers.json'
  url2 = "https://api.github.com/user/followers"
  stub_get_json(url2, filename2)

  filename3 = 'user_1_github_following.json'
  url3 = "https://api.github.com/user/following"
  stub_get_json(url3, filename3)
end

def stub_user_2_dashboard
  filename1 = 'user_2_github_repos.json'
  url1 = "https://api.github.com/user/repos?type=owner"
  stub_get_json(url1, filename1)

  filename2 = 'user_2_github_followers.json'
  url2 = "https://api.github.com/user/followers"
  stub_get_json(url2, filename2)

  filename3 = 'user_2_github_following.json'
  url3 = "https://api.github.com/user/following"
  stub_get_json(url3, filename3)
end



ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.javascript_driver = :selenium_chrome

Capybara.configure do |config|
  config.default_max_wait_time = 5
end

SimpleCov.start "rails"

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
