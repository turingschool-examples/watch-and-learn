# When I visit '/admin/tutorials/new'
# And I fill in 'title' with a meaningful name
# And I fill in 'description' with a some content
# And I fill in 'thumbnail' with a valid YouTube thumbnail
# And I click on 'Save'
# Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
# And I should see a flash message that says "Successfully created tutorial."
require 'rails_helper'

describe 'An admin can create a new tutorial' do
  let(:admin)    { create(:admin) }

  scenario 'by filling in a form' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'tutorial[title]', with: "How to do Rails"
    fill_in 'tutorial[description]', with: "Here is a video description."
    fill_in 'tutorial[thumbnail]', with: 'http://cdn3-www.dogtime.com/assets/uploads/2011/03/puppy-development-460x306.jpg'

    click_on "Save"

    expect(current_path).to eq(tutorial_path(Tutorial.last.id))

    expect(page).to have_content('Successfully created tutorial.')
  end

  it 'will receive a flash message if not created' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit new_admin_tutorial_path

    fill_in 'tutorial[title]', with: "How to do Rails"
    fill_in 'tutorial[description]', with: "Here is a video description."

    click_on "Save"
    expect(current_path).to eq(new_admin_tutorial_path)

    expect(page).to have_content('Tutorial was not created.')
  end
end
