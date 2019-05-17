# frozen_string_literal: true

require 'rails_helper'

describe 'A not logged-in user' do
  it 'cannot see turotials' do
    tutorial = create(:tutorial, title: 'I should not see this', classroom: true)
    tutorial_1 = create(:tutorial, title: 'How to Tie Your Shoes', classroom: false)

    video = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial)
    user = create(:user)

    visit root_path

    expect(page).to_not have_content(tutorial.title)
  end

  it 'cannot visit tutorial' do
    tutorial = create(:tutorial, title: 'I should not see this', classroom: true)

    visit tutorial_path(tutorial)
    expect(current_path).to eq(root_path)

  end

end
