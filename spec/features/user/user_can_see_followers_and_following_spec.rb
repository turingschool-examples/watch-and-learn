require 'rails_helper'

RSpec.describe "as a logged in user" do
  context "when i visit the user dashboard", :vcr do
    before :each do
      @user = create(:user)
    end

    it "shows a list of users i follow" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      within '.following' do
        expect(page).to have_content('People you Follow')
        expect(page).to have_link('plapicola')
        expect(page).to have_link('tnodland')
      end
    end

    it "can see users that follow me" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      within '.followers' do
        expect(page).to have_content('People who Follow you')
        expect(page).to have_link('asmolentzov')
        expect(page).to have_link('joequincy')
      end
    end
  end
end
