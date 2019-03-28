require 'rails_helper'

describe 'When a visitor visits About' do
  it 'they see information about the site' do
    visit '/about'

    expect(page).to have_content('Turing Tutorials')
  end
end
