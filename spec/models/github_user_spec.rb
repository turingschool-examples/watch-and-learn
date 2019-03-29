# frozen_string_literal: true

require 'rails_helper'

describe GithubUser do
  it 'exists' do
    repo = described_class.new(login: 'repo1', html_url: 'www.repo.com')
    expect(repo.is_a?(described_class)).to be(true)
    expect(repo.name).to eq('repo1')
    expect(repo.url).to eq('www.repo.com')
  end
end
