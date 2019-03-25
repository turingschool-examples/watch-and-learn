require 'rails_helper'

describe 'A registered user' do
  context 'visiting tutorial path for a tutorial with no videos' do
    it 'wont see any error ' do
      user = create(:user)
      tutorial = create(:tutorial)

      login_as(user)

      visit tutorial_path(tutorial)
      save_and_open_page

      expect(page).to have_content(tutorial.title)
    end
  end
end
