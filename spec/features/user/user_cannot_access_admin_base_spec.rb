# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a registered user' do
  it 'cannot access admin dashboard' do
    user = create(:user, role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    expect(status_code).to eq(404)
  end
end
