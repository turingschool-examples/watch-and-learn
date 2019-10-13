require 'rails_helper'

describe 'Admin Dashboard' do
  it 'Admin can delete tutorials' do
    admin = create(:admin)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    within(first('.admin-tutorial-card')) do
      click_on 'Destroy'
    end

    expect(current_path).to eq('/admin/dashboard')

    expect(page).to_not have_content(tutorial.title)
    expect(page).to_not have_content(tutorial.description)
  end
end
