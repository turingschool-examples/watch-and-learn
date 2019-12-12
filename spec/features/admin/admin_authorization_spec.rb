require 'rails_helper'

describe 'Admin path authorization' do

  it 'admin can visit admin path' do
    admin = create(:user, role: :admin)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    expect(current_path).to eq('/admin/dashboard')

    visit new_admin_tutorial_path
    expect(current_path).to eq('/admin/tutorials/new')

    visit edit_admin_tutorial_path(tutorial)
    expect(current_path).to eq("/admin/tutorials/#{tutorial.id}/edit")
  end

  it 'will show an error if not an admin' do
    user = create(:user, role: :default)
    tutorial = create(:tutorial)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect{ visit admin_dashboard_path }.to raise_error(ActionController::RoutingError)

    expect{ visit new_admin_tutorial_path }.to raise_error(ActionController::RoutingError)

    expect{ visit edit_admin_tutorial_path(tutorial) }.to raise_error(ActionController::RoutingError)
  end
end
