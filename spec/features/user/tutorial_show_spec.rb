require 'rails_helper'

describe 'As a user' do
  before :each do
    @tutorial = create(:tutorial, title: 'How to Tie Your Shoes')
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit tutorial_path(@tutorial)
  end

  it 'Tutorial show page will still load if no video exists.' do
    expect(page).to have_content('There are no videos for this tutorial at this time.')
    expect(page).to_not have_button('Bookmark')
  end
end
