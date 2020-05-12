require 'rails_helper'

describe "about page" do
  it "shows summary of site" do
    visit "/about"
    summary = "This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students."

    expect(page).to have_content(summary)
  end
end
