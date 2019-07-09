# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect do
      click_on 'Bookmark'
    end.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it "can't add the same bookmark more than once" do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'
    expect(page).to have_content('Bookmark added to your dashboard')
    click_on 'Bookmark'
    expect(page).to have_content('Already in your bookmarks')
  end
end
