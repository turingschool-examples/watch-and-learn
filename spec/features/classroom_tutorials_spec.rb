require 'rails_helper'

describe 'When a user views a tutorial marked as classroom content' do
  before(:each) do
    @classroom_tutorial = create(:tutorial, title: 'This is a classroom-only tutorial', classroom: true)
    create(:video, tutorial: @classroom_tutorial)
    @tutorial = create(:tutorial, title: 'Anyone can see this tutorial')
    create(:video, tutorial: @tutorial)
  end
  context 'as a logged in user' do
    it 'sees the tutorial on the welcome page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit root_path
      
      expect(page).to have_content(@classroom_tutorial.title)
      expect(page).to have_content(@tutorial.title)
      click_link(@classroom_tutorial.title)
      
      expect(current_path).to eq(tutorial_path(@classroom_tutorial))
      expect(page).to have_content(@classroom_tutorial.title)
    end
    it 'sees the tutorial on the tutorial page' do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit tutorial_path(@tutorial)
      
      expect(current_path).to eq(tutorial_path(@tutorial))
      expect(page).to have_content(@tutorial.title)
    end
  end
  
  context 'as a visitor to the site' do
    it 'does not see the tutorial' do
      visit root_path
      
      expect(page).to_not have_content(@classroom_tutorial.title)
      expect(page).to have_content(@tutorial.title)
      
      expect{visit tutorial_path(@classroom_tutorial)}.to raise_error(ActionController::RoutingError)
    end
  end
end