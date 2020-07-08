require 'rails_helper'
feature "user can add a friend" do
  it "A user can add a friend" do
    VCR.use_cassette("github_dashboard_data_including_followers_and_following") do

      user = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, username: "takeller")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      json_response = File.read('spec/fixtures/github_user_repos.json')
      stub_request(:get, "https://api.github.com/user/repos").
           with(
             headers: {
         	  'Accept'=>'*/*',
         	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         	  'Authorization'=> "token #{ENV['GITHUB_API_TOKEN_R']}",
         	  'User-Agent'=>'Faraday v1.0.1'
             }).
           to_return(status: 200, body: json_response, headers: {})
      visit dashboard_path

      within ".friend-link-#{user2.username}" do
        click_link("Add as Friend")
      end
    end

  end
end
