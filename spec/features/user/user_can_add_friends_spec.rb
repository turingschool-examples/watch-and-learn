require 'rails_helper'
describe 'A registered user' do
  it 'can see a default video on a tutorial show page when a tutorial was created without any videos', :vcr do
    json_response = File.open('./fixtures/github_repo_data.json')
    stub_request(:get, 'https://api.github.com/user/repos').to_return(status: 200, body: json_response)

    json_response = File.open('./fixtures/github_followers_data.json')
    stub_request(:get, 'http://api.github.com/user/followers').to_return(status: 200, body: json_response)

    json_response = File.open('./fixtures/github_following_data.json')
    stub_request(:get, 'https://api.github.com/user/following').to_return(status: 200, body: json_response)

    #tutorial = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)
    user = create(:user, github_token: ENV["GITHUB_API_KEY"], github_username: 49769068)
    user_2 = create(:user, github_token: ENV["LEIYA_GITHUB_API_KEY"], github_username: 45922590, first_name: "Leiya", last_name: "Kenney")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/dashboard"
    #expect(page).to have_content("leiyakenney || Add as Friend")
    expect(page).to have_button("Add as Friend")
    click_button("Add as Friend")
    expect(page).to have_content("My Friends")
    expect(page).to have_content("My Friends\nLeiya Kenney")

    expect(page).to have_button("Add as Friend")
    click_button("Add as Friend")
    expect(page).to have_content("You are already friends with this person")
  end

  # it 'has a following' do
  #   #tutorial = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)
  #   user = create(:user, github_token: ENV["GITHUB_API_KEY"], github_username: 49769068)
  #   user_2 = create(:user, github_token: ENV["LEIYA_GITHUB_API_KEY"], github_username: 45922590)
  #   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  #   following = Friendship.create!(user_id: user.id, friend_id: user_2.id)
  #   following_2 = Friendship.create!(user_id: user_2.id, friend_id: user.id)
  #   visit "/dashboard"
  # end
end
