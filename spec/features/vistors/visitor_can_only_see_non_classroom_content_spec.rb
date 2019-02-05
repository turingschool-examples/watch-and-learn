require 'rails_helper'

describe "As a visitor" do
  it "I can not see classroom content on the welcome page" do
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial, classroom: true)

    visit root_path

    expect(page).to have_content(tutorial_1.title)
    expect(page).to_not have_content(tutorial_2.title)
  end
end

describe "As a signed in user" do
  it "I can see all classroom content on the welcome page" do
    stub_login(create(:user))
    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial, classroom: true)

    visit root_path

    expect(page).to have_content(tutorial_1.title)
    expect(page).to have_content(tutorial_2.title)
  end
end
