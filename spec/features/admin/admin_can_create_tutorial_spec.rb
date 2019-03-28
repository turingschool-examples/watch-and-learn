require 'rails_helper'

describe 'an Admin' do
  it 'can create a new tutorial by filling out a form in admin new tutorial path' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path(admin)
    expect(Tutorial.count).to eq(0)

    fill_in 'tutorial[title]', with: 'first tutorial'
    fill_in 'tutorial[description]', with: 'this is first tutorial'
    fill_in 'tutorial[thumbnail]', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on 'Save'
    expect(Tutorial.count).to eq(1)
    expect(page).to have_content("Successfully created tutorial")
  end
end
