require 'rails_helper'

RSpec.describe 'A registered user' do

  it "I visit dashboard and see github section", :vcr do
    user = create(:user, github_token: ENV['GITHUB_USER_TOKEN'])
    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '.github' do
      expect(page).to have_content("Github")
      expect(page).to have_content("Repositories")
      expect(page).to have_css('.repos')
      expect(page).to have_css('.repo', count: 5)
    end

    within(first('.repo')) do
     expect(page).to have_link('activerecord-obstacle-course', href: 'https://github.com/DavidHoltkamp1/activerecord-obstacle-course')
    end
  end

  it "I see github followers in the github section of the user dashboard", :vcr do
    user = create(:user, github_token: ENV['GITHUB_USER_TOKEN'])
    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '.github' do
      expect(page).to have_content("Followers")
      expect(page).to have_css('.followers')
    end

    within '.followers' do
      expect(page).to have_link('philjdelong', href: 'https://github.com/philjdelong')
      expect(page).to have_link('PaulDebevec', href: 'https://github.com/PaulDebevec')
    end
  end

  it "I see github following section on the user dashboard", :vcr do
    user = create(:user, github_token: ENV['GITHUB_USER_TOKEN'])
    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    within '.github' do
      expect(page).to have_content("Following")
      expect(page).to have_css('.followings')
    end

    within '.followings' do
      expect(page).to have_link('philjdelong', href: 'https://github.com/philjdelong')
      expect(page).to have_link('PaulDebevec', href: 'https://github.com/PaulDebevec')
      expect(page).to have_link('BrianZanti', href: 'https://github.com/BrianZanti')
      expect(page).to have_link('dionew1', href: 'https://github.com/dionew1')
    end
  end

  it 'displays a list of all bookmarked segments under the Bookmarked Segments section', :vcr do
    user = create(:user)

    tutorial1 = create(:tutorial, title: "First Tutorial")
    video1 = create(:video, title: "First on page", tutorial_id: tutorial1.id, position: 1)
    UserVideo.create!(user: user, video: video1)

    tutorial2 = create(:tutorial, title: "Second Tutorial")
    video2 = create(:video, title: "# 1", tutorial_id: tutorial2.id, position: 0)
    video3 = create(:video, title: "# 2", tutorial_id: tutorial2.id, position: 1)
    UserVideo.create!(user: user, video: video2)
    UserVideo.create!(user: user, video: video3)

    tutorial3 = create(:tutorial)
    no_bookmark_video = create(:video, tutorial_id: tutorial3.id)

    tutorial4 = create(:tutorial, title: "Third Tutorial")
    video4 = create(:video, title: "# 2", tutorial_id: tutorial4.id, position: 1)
    UserVideo.create!(user: user, video: video4)
    video5 = create(:video, title: "Last on page", tutorial_id: tutorial4.id, position: 2)
    UserVideo.create!(user: user, video: video5)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    expect(page).to have_css(".bookmarks", count: 1)

    within(".bookmarks") do
      expect(page).to have_content("Bookmarked Segments")
      expect(page).to_not have_content(no_bookmark_video.title)
    end

    within(".bookmark-#{video1.id}") do
      expect(page).to have_link(video1.title, href: "/tutorials/#{tutorial1.id}?video_id=#{video1.id}")
    end

    within(".bookmark-#{video2.id}") do
      expect(page).to have_link(video2.title, href: "/tutorials/#{tutorial2.id}?video_id=#{video2.id}")
    end

    within(".bookmark-#{video3.id}") do
      expect(page).to have_link(video3.title, href: "/tutorials/#{tutorial2.id}?video_id=#{video3.id}")
    end

    within(".bookmark-#{video4.id}") do
      expect(page).to have_link(video4.title, href: "/tutorials/#{tutorial4.id}?video_id=#{video4.id}")
    end

    within(".bookmark-#{video5.id}") do
      expect(page).to have_link(video5.title, href: "/tutorials/#{tutorial4.id}?video_id=#{video5.id}")
    end
  end

  it "can send email invitations" do
    user = create(:user, github_token: ENV['GITHUB_USER_TOKEN_ea'])
    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)

    click_on 'Send an Invite'

    expect(current_path).to eq('/invite')

    github_handle = 'eamouzou'

    fill_in'invite[github_handle]', with: github_handle

    click_on 'Send Invite'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

end
