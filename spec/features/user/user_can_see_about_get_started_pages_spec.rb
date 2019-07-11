# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As a user' do
  context 'visiting the about page' do
    it 'shows correct info' do
      visit about_path

      expect(page).to have_content('Turing Tutorials')
    end
  end

  context 'visiting the getting started page' do
    it 'shows correct info' do
      visit get_started_path

      expect(page).to have_content('Get Started')
    end
  end
end
