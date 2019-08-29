require 'rails_helper'

feature 'as a user when I visit my dashboard' do
  scenario 'I can see a list of all bookmarked videos organized by tutorial and ordered by position' do

    stub_dashboard_api_calls
    stub_github_oauth

    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video_1 = create(:video, title: "The Bunny Ears Technique", tutorial_id: tutorial.id, position: 1)
    video_2 = create(:video, title: "Nevermind let's just stick to velcro", tutorial_id: tutorial.id, position: 3)
    video_3 = create(:video, title: "Advanced Boot lacing techniques", tutorial_id: tutorial.id, position: 2)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)
    click_on 'Bookmark'
    click_on "Nevermind let's just stick to velcro"
    click_on 'Bookmark'
    click_on 'Advanced Boot lacing techniques'
    click_on 'Bookmark'

    visit dashboard_path

    click_link "Connect to Github"
    expect(current_path).to eq(dashboard_path)

    expect(page).to have_css(".bookmarks", count: 1)
    within(first(".bookmarks")) do
      expect(page).to have_css(".tutorial")
    end

    within(first(".tutorial"))do
      expect(page).to have_content("How to Tie Your Shoes")
    end
    within(first(".videos")) do
      expect(page).to have_content("The Bunny Ears Technique")
    end

    # within(".videos") do
    #   #tesing videos are ordered by ASC position.
    #   expect(page.all('li')[0]).to have_content(video_1.title)
    #   expect(page.all('li')[1]).to have_content(video_3.title)
    #   expect(page.all('li')[2]).to have_content(video_2.title)
    # end
  end
end

# As a logged in user
# When I visit '/dashboard'
# Then I should see a list of all bookmarked segments under the Bookmarked Segments section
# And they should be organized by which tutorial they are a part of
# And the videos should be ordered by their position
