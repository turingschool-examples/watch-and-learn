require 'rails_helper'

RSpec.describe "Tutorial show page" do
  it "will show a tutorial" do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)

    visit "/tutorials/#{tutorial.id}"

    expect(page).to have_content('How to Tie Your Shoes')

    within('.video') do
      expect(page).to have_css(".title-video")
    end
  end
end
