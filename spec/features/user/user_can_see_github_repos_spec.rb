# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    before do
      create(:user, github_token: 'abcd')
      @user2 = create(:user, github_token: ENV['github_key'])
      @user3 = create(:user)
    end
    it 'can see a list of 5 of their GitHub repositories' do
      mock_user_dashboard_github
      # rubocop:disable Metrics/LineLength
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
      # rubocop:enable Metrics/LineLength

      visit dashboard_path

      expect(page).to have_content('Github')
      expect(page).to have_css('.repos')
      within '.repos' do
        expect(page).to have_link('activerecord-obstacle-course')
        expect(page).to have_link(count: 5)
      end
    end

    it 'cannot see a GitHub section if they do not have a token' do
      # rubocop:disable Metrics/LineLength
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user3)
      # rubocop:enable Metrics/LineLength

      visit dashboard_path
      expect(page).to_not have_content('Github')
    end
  end
end
