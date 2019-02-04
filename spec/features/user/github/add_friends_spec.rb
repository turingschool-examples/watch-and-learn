require "rails_helper"
describe 'friendship' do
  before(:all) { VCR.turn_off! }
  after(:all) { VCR.turn_on! }
  it 'user can add their followers / followings on github as a friend on our website' do

    user_1 = create(:user, github_token: "IFollowUser3andAmFollowedBy2")
    user_2 = create(:user, github_uid: "user_2_id")
    user_3 = create(:user, github_uid: "user_3_id")

    user_not_on_our_site = {
      "login" => "Nate",
      "uid" => "not_on_our_site_id"
    }

    stub_request(:get, "https://api.github.com/user/repos?access_token=IFollowUser3andAmFollowedBy2").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v0.15.4'
           }).
         to_return(status: 200, body: [{id: '12345',name: "brownfield-of-dreams", html_url: "https://coolurl.org"}].to_json, headers: {})

     stub_request(:get, "https://api.github.com/user/followers?access_token=IFollowUser3andAmFollowedBy2").
          with(
            headers: {
           'Accept'=>'*/*',
           'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           'User-Agent'=>'Faraday v0.15.4'
            }).
          to_return(status: 200, body: [{id: user_2.github_uid, login: "user_2_name", html_url: "https://coolurl.org"},
                                        {id: user_not_on_our_site['uid'], login: user_not_on_our_site['login'], html_url: "https://coolurl.org"}
                    ].to_json, headers: {})

      stub_request(:get, "https://api.github.com/user/following?access_token=IFollowUser3andAmFollowedBy2").
           with(
             headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Faraday v0.15.4'
             }).
           to_return(status: 200, body: [{id: user_3.github_uid, login: "user_3_name", html_url: "https://coolurl.org"},
                                         {id: user_not_on_our_site['uid'], login: user_not_on_our_site['login'], html_url: "https://coolurl.org"}
                     ].to_json, headers: {})


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    visit dashboard_path

    within("#follower-#{user_not_on_our_site['uid']}") do
      expect(page).to_not have_button("Add Friend")
    end
    within("#follower-#{user_2.github_uid}") do
      expect(page).to have_button("Add Friend")
    end
    within("#following-#{user_not_on_our_site['uid']}") do
      expect(page).to_not have_button("Add Friend")
    end
    within("#following-#{user_3.github_uid}") do
      expect(page).to have_button("Add Friend")
      click_button("Add Friend")
    end
    expect(current_path).to eq(dashboard_path)

    within("#following-#{user_3.github_uid}") do
      expect(page).to_not have_button("Add Friend")
    end

    within("#friendships") do
      expect(page).to have_content(user_3.first_name + " " + user_3.last_name)
    end
  end
end
