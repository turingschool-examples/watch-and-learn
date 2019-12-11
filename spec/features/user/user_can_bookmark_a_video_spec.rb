require 'rails_helper'

describe 'A registered user' do
  it 'can add videos to their bookmarks' do
    tutorial = create(:tutorial)
    create(:video, tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    expect { click_button 'Bookmark' }.to change { UserVideo.count }.by(1)

    expect(page).to have_content('Bookmark added to your dashboard')
  end

  it 'cannot add the same bookmark more than once' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_button 'Bookmark'

    expect(page).to have_content('Bookmark added to your dashboard')

    click_button 'Bookmark'

    expect(page).to have_content('Already in your bookmarks')
  end
end
