require "rails_helper"
describe 'admin_can_add_a_video' do
  before(:each) do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path
    #   When I visit '/admin/tutorials/new'

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
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
#

end
