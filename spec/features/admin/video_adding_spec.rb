require "rails_helper"
describe 'admin_can_add_a_video' do
  before(:each) do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path
  end
  scenario 'with good info' do
    tut_title = "Learn the right stuff"
    tut_description = "Learn the right stuff"
    tut_thumb = "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    fill_in :tutorial_title, with: tut_title
    fill_in :tutorial_description, with: tut_description
    fill_in :tutorial_thumbnail, with: tut_thumb

    click_on "Save"

    expect(current_path).to eq(tutorial_path(Tutorial.last))
    expect(page).to have_content('Successfully created tutorial.')
    visit admin_dashboard_path
    expect(page).to have_content(tut_title)
  end
  scenario 'with bad info' do
    fill_in :tutorial_title, with: ''
    fill_in :tutorial_description, with: ''
    fill_in :tutorial_thumbnail, with: 'slksdf'
    click_on "Save"
    expect(Tutorial.count).to eq(0)

    expect(page).to_not have_content('Successfully created tutorial.')

    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Thumbnail must be a valid link")
  end
end

describe 'non admins are redirected' do
  it 'redirects a visitor' do
    expect{visit new_admin_tutorial_path}.to raise_error(ActionController::RoutingError)
  end
  it 'redirects a user' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    expect{visit new_admin_tutorial_path}.to raise_error(ActionController::RoutingError)
  end
end
