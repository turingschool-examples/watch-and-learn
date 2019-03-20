require 'rails_helper'

RSpec.describe 'Admin can create a Tutorial' do
  describe 'As a logged in admin user' do
    before :each do
      @admin = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    describe 'when I visit my dashboard' do
      describe 'and click on New Tutorial' do
        it 'can create a new tutorial' do
          visit admin_dashboard_path

          click_link("New Tutorial")

          expect(current_path).to eq(new_admin_tutorial_path)

          fill_in 'tutorial[title]', with: 'Tutorial Title Test'
          fill_in 'tutorial[description]', with: 'Tutorial description test'
          fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
          click_on "Save"

          new_tutorial = Tutorial.last
          expect(new_tutorial.title).to eq('Tutorial Title Test')
          expect(current_path).to eq(admin_dashboard_path)
          expect(page).to have_content('Tutorial Title Test')

          click_on(new_tutorial.title)
          expect(current_path).to eq(tutorial_path(new_tutorial))

        end

        it 'if tutorial info is missing, it reloads the page' do
          visit admin_dashboard_path

          click_link("New Tutorial")

          expect(current_path).to eq(new_admin_tutorial_path)

          fill_in 'tutorial[title]', with: ''
          fill_in 'tutorial[description]', with: 'Tutorial description test'
          fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
          click_on "Save"

          expect(Tutorial.last).to eq(nil)

        end
      end
    end
  end
end
