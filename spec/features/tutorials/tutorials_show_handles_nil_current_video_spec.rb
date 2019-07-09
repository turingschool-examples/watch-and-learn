# frozen_string_literal: true

require 'rails_helper'

describe 'visitor sees a video show' do
  it 'visitor clicks on a tutorial title from the home page' do
    tutorial = create(:tutorial)

    visit tutorial_path(tutorial)

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
