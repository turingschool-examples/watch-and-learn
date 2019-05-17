# frozen_string_literal: true

require 'rails_helper'

describe 'as a visitor' do
  it 'cant see classroom content' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, classroom: true)

    visit root_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to_not have_content(tutorial2.title)
  end

  it 'shows all videos for logged in user' do
    user = create(:user)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, classroom: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(user)

    visit root_path

    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial2.title)
  end
end
