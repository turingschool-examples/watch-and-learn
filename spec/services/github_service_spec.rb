# frozen_string_literal: true

require 'rails_helper'

describe GithubService do
  it 'exists' do
    service = described_class.new
    expect(service.is_a?(described_class)).to be(true)
  end

  context 'instance methods' do
    context '#get_user_repos' do
      it 'returns repos', :vcr do
        user = create(:user, github_token: ENV['github_key'])

        service = described_class.new

        result = service.get_user_repos(user)
        expect(result.is_a?(Array)).to be(true)
        expect(result[0].key?(:html_url)).to be(true)
        expect(result[0].key?(:full_name)).to be(true)
      end
    end

    context '#get_user_followers' do
      it 'returns followers', :vcr do
        user = create(:user, github_token: ENV['github_key'])

        service = described_class.new

        result = service.get_user_followers(user)
        expect(result.is_a?(Array)).to be(true)

        expect(result[0].key?(:login)).to be(true)
        expect(result[0].key?(:html_url)).to be(true)
      end
    end

    context '#get_user_following' do
      it 'returns following', :vcr do
        user = create(:user, github_token: ENV['github_key'])

        service = described_class.new

        result = service.get_user_following(user)
        expect(result.is_a?(Array)).to be(true)

        expect(result[0].key?(:login)).to be(true)
        expect(result[0].key?(:html_url)).to be(true)
      end
    end

    context '#get_user_email(username)' do
      it 'returns user\'s email', :vcr do
        user = create(:user, github_token: ENV['github_key'])
        service = GithubService.new

        result = service.get_user_email('manojpanta', user)
        expect(result.is_a?(String)).to be(true)
        expect(result).to eq('manojpanta95@gmail.com')
      end
    end
  end
end
