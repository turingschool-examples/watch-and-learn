# frozen_string_literal: true

require 'rails_helper'

describe 'A registered user' do
  context 'visiting /dashboard' do
    before do
      create(:user, github_token: 'abcd')
      @user_2 = create(:user, github_token: ENV['github_key'])
      @user_3 = create(:user)
    end

    it 'can see a list of 5 of their GitHub repositories' do
      mock_user_dashboard_github

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

      visit dashboard_path

      expect(page.has_content?('Github')).to be(true)
      expect(page.has_css?('.repos')).to be(true)
      within '.repos' do
        expect(page.has_link?('activerecord-obstacle-course')).to be(true)
        expect(page.has_link?(count: 5)).to be(true)
      end
    end

    it 'cannot see a GitHub section if they do not have a token' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_3)

      visit dashboard_path
      expect(page.has_content?('Github')).to be(false)
    end
  end
end
