require 'rails_helper'

RSpec.describe "As a visitor" do
  it "will display about page" do

    visit '/about'

    within '.about-header' do
      expect(page).to have_content('Turing Tutorials')
    end
  end
end
