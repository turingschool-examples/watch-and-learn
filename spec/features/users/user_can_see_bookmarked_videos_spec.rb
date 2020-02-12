require 'rails_helper'

describe 'As a logged in user' do
  it 'I can see a list of videos I have bookmarked sorted by tutorial and then video' do
    tutorial_1 = create(:tutorial, title: "How to Tie Your Shoes")
    video_1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
    video_2 = create(:video, title: "The Deer Horn Technique", tutorial: tutorial_1)

    tutorial_2 = create(:tutorial, title: "How to Tie a Tie")
    video_3 = create(:video, title: "The Windsor Knot Method", tutorial: tutorial_2)
    video_4 = create(:video, title: "The Nicky Knot Method", tutorial: tutorial_2)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial_1)
    click_button 'Bookmark'
    click_link 'The Deer Horn Technique'
    click_button 'Bookmark'

    visit tutorial_path(tutorial_2)
    click_link 'The Nicky Knot Method'
    click_button 'Bookmark'

    visit dashboard_path

    within '.bookmarks' do
      within "#video-#{video_1.id}" do
        expect(page).to have_content('How to Tie Your Shoes')
        expect(page).to have_content('The Bunny Ears Technique')
      end
      within "#video-#{video_2.id}" do
        expect(page).to have_content('How to Tie Your Shoes')
        expect(page).to have_content('The Deer Horn Technique')
      end
      within "#video-#{video_4.id}" do
        expect(page).to have_content('How to Tie a Tie')
        expect(page).to have_content('The Nicky Knot Method')
      end
    end
  end
end
