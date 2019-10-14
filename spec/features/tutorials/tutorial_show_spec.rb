require 'rails_helper'

describe 'user/visitor visits a tutorial show page' do
  it 'tutorial without videos displays notice' do
    tutorial = create(:tutorial)
    visit '/'

    click_on tutorial.title

    expect(page).to have_content("There are currently no videos available for this tutorial.")
  end
end
