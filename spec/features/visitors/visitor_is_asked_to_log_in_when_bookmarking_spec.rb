require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark link and is displayed a tooltip to login/register' do
    tutorial = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    find('.tooltiptext').should have_content('Please Sign In or Register')

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
