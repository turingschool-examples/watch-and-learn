# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    it 'can see a list of everyone they are following on GitHub' do
      user = create(:user, github_token: ENV['github_key'])

      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page.has_content?('Github')).to be(true)
      expect(page.has_content?('Following')).to be(true)

      expect(page.has_css?('.following')).to be(true)
      within '.following' do
        expect(page.has_link?('manojpanta')).to be(true)
      end
    end
  end
end
