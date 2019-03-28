require 'rails_helper'

describe "As a visitor" do
  it "I see info about this project" do
    visit about_path

    expect(page).to have_content("This application is designed to pull in youtube information")
  end
end
