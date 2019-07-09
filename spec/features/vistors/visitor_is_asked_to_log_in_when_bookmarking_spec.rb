# # frozen_string_literal: true
require 'rails_helper'

describe 'when a visitor is viewing a tutorial' do
  it "doesn't allow bookmarking if not logged in" do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)
    click_on 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('User must login to bookmark videos.')
  end
end
