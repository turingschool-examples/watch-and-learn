require 'rails_helper'

describe 'When a visitor visits a page they don\'t have access to' do
  it 'they receive a 404' do
    user = create(:user)
    create(:tutorial)
    login_as(user)
    expect { visit 'admin/tutorials/1/edit' }.to raise_error(ActionController::RoutingError)
  end
end
