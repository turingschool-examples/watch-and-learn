# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of all of their github followers' do
      user = create(:user, github_token: ENV['github_key'])

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page.has_content?('Github')).to be(true)
      expect(page.has_content?('Followers')).to be(true)

      expect(page.has_css?('.followers')).to be(true)
      within '.followers' do
        expect(page.has_link?('stiehlrod')).to be(true)
      end
    end
  end
end
