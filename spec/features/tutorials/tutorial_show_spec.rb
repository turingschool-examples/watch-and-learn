require 'rails_helper'

RSpec.describe "Tutorial show page" do
  it "displays all videos" do
    tut1 = create(:tutorial)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)

    visit tutorial_path(tut1)

    expect(current_path).to eq(tutorial_path(tut1))
    expect(page).to have_content(tut1.title)
    expect(page).to have_content(vid1.title)
    expect(page).to have_content(vid2.title)
  end

  it "displays correctly when it has no videos" do
    tut1 = create(:tutorial)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)
    tut2 = create(:tutorial)

    visit tutorial_path(tut2)

    expect(current_path).to eq(tutorial_path(tut2))
    expect(page).to have_content("This tutorial doesn't have any videos yet, but we're working on it!")
  end

  it "displays classroom content to logged-in users" do
    user = create(:user, email_confirmed: true)
    tut1 = create(:tutorial, classroom: false)
    tut2 = create(:tutorial, classroom: true)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)
    vid3, vid4 = create_list(:video, 2, tutorial: tut2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tut1)

    expect(page).to have_content(tut1.title)
    expect(page).to have_content(vid1.title)
    expect(page).to have_content(vid2.title)
    expect(page).to_not have_content("Sorry, this content is for registered users only! Please create an account to continue.")

    visit tutorial_path(tut2)

    expect(page).to have_content(tut2.title)
    expect(page).to have_content(vid3.title)
    expect(page).to have_content(vid4.title)
    expect(page).to_not have_content("Sorry, this content is for registered users only! Please create an account to continue.")
  end

  it "doesn't display classroom content to non-logged-in users" do
    tut1 = create(:tutorial, classroom: false)
    tut2 = create(:tutorial, classroom: true)
    vid1, vid2 = create_list(:video, 2, tutorial: tut1)
    vid3, vid4 = create_list(:video, 2, tutorial: tut2)

    visit tutorial_path(tut1)

    expect(page).to have_content(tut1.title)
    expect(page).to have_content(vid1.title)
    expect(page).to have_content(vid2.title)
    expect(page).to_not have_content("Sorry, this content is for registered users only! Please create an account to continue.")

    visit tutorial_path(tut2)

    expect(page).to have_content("Sorry, this content is for registered users only! Please create an account to continue.")
    expect(page).to_not have_content(tut2.title)
    expect(page).to_not have_content(vid1.title)
    expect(page).to_not have_content(vid2.title)
  end
end
