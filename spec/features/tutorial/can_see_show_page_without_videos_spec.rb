# frozen_string_literal: true

require 'rails_helper'

describe 'as a visitor' do
  it 'should tutorial even if no videos are present' do
    tutorial = create(:tutorial)

    visit tutorial_path(tutorial.id)

    expect(page).to have_content(tutorial.title)
    expect(page).to have_content('More to come')
  end
end
