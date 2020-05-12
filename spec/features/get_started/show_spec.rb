require 'rails_helper'

describe "get started page" do
  it "explains how to use the application" do
    visit "/about"
    click_on "Get Started"

    tutorial1 = "Browse tutorials from the homepage."
    tutorial2 = "Filter results by selecting a filter on the side bar of the homepage."
    tutorial3 = "Register to bookmark segments."
    tutorial4 = "Sign in with census if you are a current student for addition content."

    expect(page).to have_content(tutorial1)
    expect(page).to have_content(tutorial2)
    expect(page).to have_content(tutorial3)
    expect(page).to have_content(tutorial4)
  end
end
