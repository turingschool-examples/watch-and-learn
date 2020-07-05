require 'rails_helper'

describe 'An admin user can create a new tutorial' do
  it 'submits a valid form' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in'Title', with: "New Tutorial"
    fill_in'Description', with: "Decription stuff"
    fill_in'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on 'Save'

    expect(current_path).to eq("/tutorials/#{Tutorial.last.id}")
    expect(page).to have_content("Successfully created tutorial.")
  end
  it 'submits an invalid form' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in'Title', with: ""
    fill_in'Description', with: "Decription stuff"
    fill_in'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on 'Save'

    expect(current_path).to eq("/admin/tutorials/new")
    expect(page).to have_content("tutorial not created!")

    fill_in'Title', with: "New Tutorial"
    fill_in'Description', with: ""
    fill_in'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_on 'Save'

    expect(current_path).to eq("/admin/tutorials/new")
    expect(page).to have_content("tutorial not created!")

    fill_in'Title', with: "New Tutorial"
    fill_in'Description', with: "Descripto man"
    fill_in'Thumbnail', with: ""

    click_on 'Save'

    expect(current_path).to eq("/admin/tutorials/new")
    expect(page).to have_content("tutorial not created!")
  end
end
