require 'rails_helper'

describe Repo do
  it 'exists' do
    repo = Repo.new({})
    expect(repo).to be_a(Repo)
  end
end
