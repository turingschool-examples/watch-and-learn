require 'rails_helper'

RSpec.describe 'An Admin can ...' do
  let(:admin)    { create(:admin) }

  it 'create a new tutorial' do

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    click_on 'New Tutorial'

    fill_in  'Title', with: 'Billy Title'
    fill_in 'Description', with: 'Billy Description'
    fill_in 'Thumbnail', with: 'https://www.youtube.com/watch?v=WWcbcNlsK7U&t=587s'
    click_on 'Save'

    tutorial = Tutorial.last

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to have_content('Successfully created tutorial.')
  end
end
