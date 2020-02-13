# frozen_string_literal: true

require 'rails_helper'

describe 'login to bookmark' do
  it ' click bookmark' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)
    create(:video, tutorial_id: tutorial.id)

    visit "/tutorials/#{tutorial.id}"

    click_on 'Bookmark'

    expect(current_path).to eq(login_path)

    expect(page).to have_content('Must Login to Bookmar')
  end
end
