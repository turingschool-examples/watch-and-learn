# frozen_string_literal: true

require 'rails_helper'

describe 'When a visitor visits About' do
  it 'they see information about the site' do
    visit '/about'

    expect(page.has_content?('Turing Tutorials')).to be(true)
  end
end
