# frozen_string_literal: true

require 'rails_helper'

describe 'When a visitor visits a page they don\'t have access to' do
  it 'they receive a 404' do
    user = create(:user)
    create(:tutorial)
    login_as(user)
    error = ActionController::RoutingError
    expect { visit 'admin/tutorials/1/edit' }.to raise_error(error)
  end
end
