# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /tutorials' do
    it 'can see all videos marked as "classroom content"' do
      user = create(:user)
      create_list(:tutorial, 1)
      create_list(:tutorial, 10, classroom: true)

      visit tutorials_path
      within('.tutorials') do
        expect(page.has_link?(count: 1)).to be(true)
      end

      login_as(user)
      visit tutorials_path
      within('.tutorials') do
        expect(page.has_link?(count: 11)).to be(true)
      end
    end
  end
end
