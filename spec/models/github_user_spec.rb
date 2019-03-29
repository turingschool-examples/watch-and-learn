# frozen_string_literal: true

require 'rails_helper'

describe GithubUser do
  it 'exists' do
    repo = GithubUser.new(login: 'repo1', html_url: 'www.repo.com')
    expect(repo).to be_a(GithubUser)
    expect(repo.name).to eq('repo1')
    expect(repo.url).to eq('www.repo.com')
  end
end
