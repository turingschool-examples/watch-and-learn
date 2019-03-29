# frozen_string_literal: true

require 'rails_helper'

describe Repo do
  it 'exists' do
    repo = Repo.new({name: 'repo1', html_url: 'www.repo.com'})
    expect(repo).to be_a(Repo)

    ##spies
    allow(repo).to receive(:name).and_return('not repo1')
    allow(repo).to receive(:url).and_return('www.notrepo.com')

    expect(repo.name).to eq('not repo1')
    expect(repo.url).to eq('www.notrepo.com')
  end
end
