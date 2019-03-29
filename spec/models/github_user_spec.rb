# frozen_string_literal: true

require 'rails_helper'

describe GithubUser do
  it 'exists' do
    user = GithubUser.new(login: 'repo1', html_url: 'www.repo.com')
    
    expect(user).to be_a(GithubUser)
    ##spies
    allow(user).to receive(:name).and_return('spied user')
    allow(user).to receive(:url).and_return('spied.com')

    expect(user.name).to eq('spied user')
    expect(user.url).to eq('spied.com')
  end
end
