require 'rails_helper'

RSpec.describe 'As a registered user' do
  describe 'on the home page' do

    it "shows tutorials that are classroom content" do
      tutorial = create(:tutorial, classroom: true)
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within '.tutorial' do
        expect(page).to have_content(tutorial.title)
        expect(page).to have_content(tutorial.description)
      end
    end
  end
end
