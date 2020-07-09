require 'rails_helper'

describe "as a user" do
  it "shows the tutorials on the index page" do
    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path
    expect(page).to have_content(tutorial.title)
  end

  it "shows only non-classroom videos to non-users" do
    tutorial = create(:tutorial, title: "How to Tie Your Shoes", classroom: true)
    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
    video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial)
    tutorial2 = create(:tutorial, title: "How to Tie Your Shoes", classroom: true)

    visit root_path

    expect(page).to_not have_content(tutorial.title)
  end

end
