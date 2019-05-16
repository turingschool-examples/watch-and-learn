require 'rails_helper'

context 'As a logged-in admin' do
  it 'can successfully add a tutorial' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_link 'New Tutorial'

    expect(current_path).to eq(new_admin_tutorial_path)

    fill_in 'tutorial[title]', with: 'Meaningful Tutorial Title'
    fill_in 'tutorial[description]', with: 'The description for the meaningful tutorial above.'
    fill_in 'tutorial[thumbnail]', with: 'https://youtu.be/J7ikFUlkP_k'
    click_button 'Save'

    new_tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(new_tutorial))
    expect(page).to have_content('Successfully created tutorial')
    expect(page).to have_content('Meaningful Tutorial Title')
  end

  it 'displays an error if tutorial is not added successfully' do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_link 'New Tutorial'

    fill_in 'tutorial[title]', with: 'Meaningful Tutorial Title'
    fill_in 'tutorial[description]', with: 'The description for the meaningful tutorial above.'
    fill_in 'tutorial[thumbnail]', with: 'https://youtu.be/J7ikFUlkP_k'
    click_button 'Save'

  end
end
