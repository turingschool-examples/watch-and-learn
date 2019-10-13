require 'rails_helper'

describe 'Admin Dashboard' do
  it 'Admin can delete tutorials and vidos in those tutorials' do
    admin = create(:admin)
    tutorial1 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    within(first('.admin-tutorial-card')) do
      click_on 'Destroy'
    end
    expect(current_path).to eq('/admin/dashboard')

    expect(page).to_not have_content(tutorial1.title)
    expect(page).to_not have_content(tutorial1.description)

    expect(tutorial1.videos).to eq([])
  end
end
