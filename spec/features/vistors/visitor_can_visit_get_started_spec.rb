# frozen_string_literal: true

require 'rails_helper'

describe 'When a visitor visits Get Started' do
  it 'they see information on how to use' do
    visit '/get_started'

    expect(page.has_content?('Get Started')).to be(true)
    expect(page.has_link?('homepage')).to be(true)
    expect(page.has_link?('Sign in')).to be(true)
  end
end
