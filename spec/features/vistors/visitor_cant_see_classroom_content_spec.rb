require 'rails_helper'

describe 'visitor visits root page' do
  it 'visitor doesnt see classroom content' do
    tutorial = create(:tutorial, classroom: true)
    tutorial2 = create(:tutorial)
    video = create(:video, tutorial_id: tutorial.id)
    video1 = create(:video, tutorial_id: tutorial2.id)

    visit "/"

    expect(page).to have_content(tutorial2.title)
    expect(page).to_not have_content(tutorial.title)
    user = create(:user)

    click_on "Sign In"

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'
    visit "/"
    expect(page).to have_content(tutorial2.title)
    expect(page).to have_content(tutorial.title)
  end
end
