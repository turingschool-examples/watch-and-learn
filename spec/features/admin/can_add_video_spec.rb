# frozen_string_literal: true

require 'rails_helper'

describe 'an admin' do
  it 'can add a video' do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController)
      .to receive(:current_user)
      .and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'Title', with: 'Bugs Bunny'
    fill_in 'Description', with: 'Saturday morning cartoons'
    fill_in 'Thumbnail', with: 'https://youtu.be/uYBce9Gsz7g'

    click_on 'Save'

    tutorial = Tutorial.last
    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))
  end
end
