require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    tutorial= create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  xit "can't add the same bookmark more than once" do
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)

    tutorial2 = create(:tutorial)
    video3 = create(:video, tutorial_id: tutorial2.id)

    tutorial3 = create(:tutorial)
    video4 = create(:video, tutorial_id: tutorial3.id)

    user = create(:user)

    #As a logged in user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial1)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")

    click_on "#{video2.title}"
    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")

    visit tutorial_path(tutorial3)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")

    stub_user_1_dashboard

    #When I visit '/dashboard'
    visit dashboard_path

    #Then I should see a list of all bookmarked segments under the Bookmarked Segments section
    #And they should be organized by which tutorial they are a part of
    #And the videos should be ordered by their position
    expect(page).to have_content('Bookmarked Segments')

    within('.bookmarked-segments') do
      expect(page).to have_css('.bookmarked-tutorial', count: 2)
      expect(page).to have_css('.bookmarked-video', count: 3)

      expect(page.all('.bookmarked-tutorial')[0]).to have_content("#{tutorial1.title}")
      expect(page.all('.bookmarked-tutorial')[0]).to have_css('.bookmarked-video', count: 2)
      expect(page.all('.bookmarked-video')[0]).to have_content("#{video1.title}")
      expect(page.all('.bookmarked-video')[1]).to have_content("#{video2.title}")

      expect(page.all('.bookmarked-tutorial')[1]).to have_content("#{tutorial3.title}")
      expect(page.all('.bookmarked-tutorial')[1]).to have_css('.bookmarked-video', count: 1)
      expect(page.all('.bookmarked-video')[2]).to have_content("#{video4.title}")

      #   within('.bookmarked-video'[0]) do
      #     expect(page).to have_content("#{video1.title}")
      #   end
      #   within('.bookmarked-video'[1]) do
      #     expect(page).to have_content("#{video2.title}")
      #   end
      # end
      # within('.bookmarked-tutorial'[1]) do
      #   expect(page).to have_content("#{tutorial3.title}")
      #   within('.bookmarked-video'[2]) do
      #     expect(page).to have_content("#{video4.title}")
      #   end
      # end
      expect(page).to_not have_content("#{tutorial2.title}")
      expect(page).to_not have_content("#{video3.title}")
    end

  end
end
