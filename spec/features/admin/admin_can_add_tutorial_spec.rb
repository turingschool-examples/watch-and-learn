require 'rails_helper'

context 'As a logged-in admin' do
  it 'can successfully add a tutorial' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_link 'New Tutorial'
    # When I visit '/admin/tutorials/new'
    expect(current_path).to eq(new_admin_tutorial_path)
    # And I fill in 'title' with a meaningful name
    fill_in 'tutorial[title]', with: 'Test'
    # And I fill in 'description' with a some content
    fill_in 'tutorial[description]', with: 'Stuff'
    # And I fill in 'thumbnail' with a valid YouTube thumbnail
    # This is a thumbnail: https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg
    fill_in 'tutorial[thumbnail]', with: 'https://youtu.be/J7ikFUlkP_k'
    # And I click on 'Save'
    click_button 'Save'
    # Then I should be on '/tutorials/{NEW_TUTORIAL_ID}'
    # And I should see a flash message that says "Successfully created tutorial."
    new_tutorial = Tutorial.last
    binding.pry
    expect(current_path).to eq(tutorial_path(new_tutorial))
    # expect(current_path).to eq(admin_dashboard_path)

    expect(page).to have_content('Successfully created tutorial')
  end
end
