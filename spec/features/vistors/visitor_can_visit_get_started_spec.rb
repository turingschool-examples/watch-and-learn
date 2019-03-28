require 'rails_helper'

describe 'When a visitor visits Get Started' do
  it 'they see information on how to use' do
    visit '/get_started'

    expect(page).to have_content('Get Started')
    expect(page).to have_link('homepage')
    expect(page).to have_link('Sign in')
  end
end
