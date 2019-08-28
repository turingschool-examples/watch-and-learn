require 'rails_helper'

feature 'tutorial show page' do
  scenario 'does not error out if there are no videos' do
    t1 = create(:tutorial)

    visit tutorial_path(t1)
  end
end
