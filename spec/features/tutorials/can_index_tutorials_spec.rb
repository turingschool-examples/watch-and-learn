require 'rails_helper'

RSpec.describe "Tutorial show page" do
  it "will show a tutorial" do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    tutorial_1 = create(:tutorial, title: 'How to Tie Your title')
    tutorial_2 = create(:tutorial, title: 'How to I dont know')
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    create(:video, title: 'The Loop and Swoop', tutorial: tutorial_1)
    create(:video, title: 'The slippers', tutorial: tutorial_2)

    visit '/'

    within(first(".tutorial")) do
      expect(page).to have_content('How to Tie Your Shoes')
    end
  end
end
