require 'rails_helper'

describe 'An admin user can destroy tutorials' do
  it 'clicks on the delete button to destroy tutorials' do
    admin = create(:user, role: 1)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(Video.count).to eq(3)
    expect(Tutorial.count).to eq(2)

    within(first("#update-#{tutorial1.id}")) do
      click_on 'Destroy'
    end

    expect(current_path).to eq("/admin/dashboard")
    expect(Video.count).to eq(1)
    expect(Tutorial.count).to eq(1)
  end
end
