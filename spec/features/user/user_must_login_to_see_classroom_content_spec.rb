require 'rails_helper'

feature 'as a user I must log in' do
  scenario 'in order to see classroom content' do
    madi = create(:user)
    tut1 = create(:tutorial)
    tut2 = create(:tutorial, classroom: true)


    visit root_path

    expect(page).to have_content(tut1.title)
    expect(page).to_not have_content(tut2.title)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(madi)

    expect(page).to have_content(tut1.description)
    expect(page).to have_content(tut2.description)
    expect(page).to have_css(".tutorials col md-col-8", count: 2)
  end
end
