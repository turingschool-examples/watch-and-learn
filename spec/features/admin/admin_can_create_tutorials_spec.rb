require 'rails_helper'

describe 'An admin user can add tags to tutorials' do
  it 'clicks on the add tag on a tutoral' do
    admin = create(:user, role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit "/admin/dashboard"
    click_on "New Tutorial"
    fill_in'tutorial[title]', with: "Eating Food"
    fill_in'tutorial[description]', with: "Grubbing down with the homies"
    fill_in'tutorial[thumbnail]', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"
    click_on "Save"
    expect(current_path).to eq(admin_dashboard_path)




  end
end
