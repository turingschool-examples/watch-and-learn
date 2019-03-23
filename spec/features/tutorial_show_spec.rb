require 'rails_helper'

RSpec.describe 'Tutorial show page' do
  describe 'if a tutorial is classroom content' do
    before :each do
      @tutorial1 = create(:tutorial, title: 'Test title', classroom: true)
      @tutorial2 = create(:tutorial, title: 'Test tutorial 2 title', classroom: false)

      @video1 = create(:video, tutorial: @tutorial1)
      @video2 = create(:video, tutorial: @tutorial2)

      @user = create(:user)
    end
    describe 'as a visitor' do
      it 'does not show the tutorial videos' do

        visit root_path
        click_on @tutorial1.title

        expect(page).to have_content("You need to login to see this tutorial.")
        expect(page).to_not have_content(@video1.title)

        visit root_path
        click_on @tutorial2.title
        expect(page).to have_content(@video2.title)
      end
    end

    describe 'as a logged in user' do
      it 'should show all videos for a classroom only tutorial' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit root_path
        click_on @tutorial1.title

        expect(page).to_not have_content("You need to login to see this tutorial.")
        expect(page).to have_content(@video1.title)
      end
    end

  end
end
