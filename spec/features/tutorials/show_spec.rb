require 'rails_helper'

feature 'tutorial show page' do
  scenario 'does not error out if there are no videos' do
    t1 = create(:tutorial)

    visit tutorial_path(t1)

  end
end

# A possible easy fix is to default to Video.new if there aren't
# any videos associated with the tutorial.
