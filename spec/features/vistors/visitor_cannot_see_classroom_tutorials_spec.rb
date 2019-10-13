require 'rails_helper'

describe 'A visitor' do
  it 'cannot see  tutorials marked for classroom purposes and cannot navigate to those pages' do
    tutorial = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)
    tutorial_1 = create(:tutorial, title: 'How to Tie Decorate a Christmas Tree', classroom: true)
    tutorial_2 = create(:tutorial, title: 'How to Make Sushi', classroom: false)
    tutorial_3 = create(:tutorial, title: 'How to Dance', classroom: true)
    tutorial_4 = create(:tutorial, title: 'How to Style Your Hair', classroom: false)
    tutorial_5 = create(:tutorial, title: 'How to Style Your Hair: The Sequel', classroom: false)
    tutorial_6 = create(:tutorial, title: 'How to Style Your Hair 3', classroom: false)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_1)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_2)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_3)
    create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial_4)

    visit "/tutorials/#{tutorial_3.id}"
    expect(page).to have_content("The page you were looking for doesn't exist (404)")
    visit "/tutorials/#{tutorial.id}"
    expect(page).to have_content(tutorial.title)


    visit "/"
    expect(page).to have_content(tutorial.title)
    expect(page).to_not have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
    expect(page).to_not have_content(tutorial_3.title)
    expect(page).to have_content(tutorial_4.title)
    expect(page).to have_content(tutorial_5.title)
    expect(page).to have_content(tutorial_6.title)
  end
end
