require 'rails_helper'

describe 'only an admin can reach admin paths' do
  it 'does not allow visitors or regular users in ' do
    user = create(:user)
    admin = create(:admin)

    expect{visit admin_dashboard_path}.to raise_error(ActionController::RoutingError)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect{visit admin_dashboard_path}.to raise_error(ActionController::RoutingError)
    
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path
    expect(page).to have_content("Admin Dashboard")
  end
end
