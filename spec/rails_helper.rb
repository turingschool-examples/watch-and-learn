require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'pry'
require './app/helpers/authentication'

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YOUTUBE_API_KEY>") { ENV['YOUTUBE_API_KEY'] }
  config.filter_sensitive_data("<GITHUB_API_KEY>") { ENV['github_key'] }
end


def stub_get_json(url, filename)
  json_response = File.open("./fixtures/#{filename}")
  stub_request(:get, url).
    to_return(body: json_response, status: 200)
end

def  mock_user_dashboard_github
  filename = 'user_following.json'
  url = "https://api.github.com/user/following"
  stub_get_json(url, filename)

  filename = 'user_followers.json'
  url = "https://api.github.com/user/followers"
  stub_get_json(url, filename)

  filename = 'user_repos.json'
  url = "https://api.github.com/user/repos"
  stub_get_json(url, filename)
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

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({"provider"=>"github",
 "uid"=>"34468256",
 "info"=>{"nickname"=>"manojpanta", "email"=>nil, "name"=>"Manoj Panta", "image"=>"https://avatars1.githubusercontent.com/u/34468256?v=4", "urls"=>{"GitHub"=>"https://github.com/manojpanta", "Blog"=>""}},
 "credentials"=>{"token"=>"1360c3d8bc8b4cb095fd9cd008d3021d9b0fe160", "expires"=>false},
 "extra"=>
  {"raw_info"=>
    {"login"=>"manojpanta",
     "id"=>34468256,
     "node_id"=>"MDQ6VXNlcjM0NDY4MjU2",
     "avatar_url"=>"https://avatars1.githubusercontent.com/u/34468256?v=4",
     "gravatar_id"=>"",
     "url"=>"https://api.github.com/users/manojpanta",
     "html_url"=>"https://github.com/manojpanta",
     "followers_url"=>"https://api.github.com/users/manojpanta/followers",
     "following_url"=>"https://api.github.com/users/manojpanta/following{/other_user}",
     "gists_url"=>"https://api.github.com/users/manojpanta/gists{/gist_id}",
     "starred_url"=>"https://api.github.com/users/manojpanta/starred{/owner}{/repo}",
     "subscriptions_url"=>"https://api.github.com/users/manojpanta/subscriptions",
     "organizations_url"=>"https://api.github.com/users/manojpanta/orgs",
     "repos_url"=>"https://api.github.com/users/manojpanta/repos",
     "events_url"=>"https://api.github.com/users/manojpanta/events{/privacy}",
     "received_events_url"=>"https://api.github.com/users/manojpanta/received_events",
     "type"=>"User",
     "site_admin"=>false,
     "name"=>"Manoj Panta",
     "company"=>nil,
     "blog"=>"",
     "location"=>nil,
     "email"=>nil,
     "hireable"=>nil,
     "bio"=>nil,
     "public_repos"=>60,
     "public_gists"=>2,
     "followers"=>4,
     "following"=>8,
     "created_at"=>"2017-12-12T05:31:06Z",
     "updated_at"=>"2019-03-21T16:49:21Z"},
   "all_emails"=>[]}})

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.include FactoryBot::Syntax::Methods

  config.include Helpers::Authentication, type: :feature

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
