require 'rails_helper'

RSpec.describe 'Tutorials users can see' do
  it 'A user not logged in can only seed tutorials where classroom.tutorial == false ' do
    tutorial_1= create(:tutorial, title: "How to Tie Your Shoes")
    tutorial_2= create(:tutorial, title: "This was has classroom = true", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial_1)
    user = create(:user)

    visit '/'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to_not have_content(tutorial_2.title)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
