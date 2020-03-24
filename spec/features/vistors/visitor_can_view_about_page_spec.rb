require 'rails_helper'

RSpec.describe 'visitor can view about page', type: :feature do
  it "describes what the website is for" do
    visit '/about'

    expect(page).to have_content('Turing Tutorials')
  end
end
