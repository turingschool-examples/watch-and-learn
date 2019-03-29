# frozen_string_literal: true

require 'rails_helper'

describe 'An admin visiting the admin dashboard' do
  it 'can see all tutorials' do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/admin/dashboard'

    expect(page.has_css?('.admin-tutorial-card', count: 2)).to be(true)
  end
end
