require 'rails_helper'

describe 'A registered user' do
  it 'can see all tutorials marked for both classroom and non-classroom purposes' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)
    tutorial_1 = create(:tutorial, title: 'How to Tie Decorate a Christmas Tree', classroom: true)
    tutorial_2 = create(:tutorial, title: 'How to Make Sushi', classroom: false)
    tutorial_3 = create(:tutorial, title: 'How to Dance', classroom: true)
    tutorial_4 = create(:tutorial, title: 'How to Style Your Hair', classroom: false)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_2)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_3)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_4)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/tutorials/#{tutorial_3.id}"
    expect(page).to have_content(tutorial_3.title)
    visit "/tutorials/#{tutorial.id}"
    expect(page).to have_content(tutorial.title)


    visit "/"
    expect(page).to have_content(tutorial.title)
    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
    expect(page).to have_content(tutorial_3.title)
    expect(page).to have_content(tutorial_4.title)
  end
end
