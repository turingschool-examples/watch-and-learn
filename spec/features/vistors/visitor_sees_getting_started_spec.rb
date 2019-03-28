require 'rails_helper'

describe "As a visitor" do
  it "I see 'getting started' info about this project" do

    visit get_started_path

    expect(page).to have_content("Get Started")
    expect(page).to have_link("homepage")
    expect(page).to have_link("Sign in")
  end
end
