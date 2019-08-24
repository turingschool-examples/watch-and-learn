require 'rails_helper'

RSpec.describe Repository do
  it 'exists' do
    attrs = {
      name: "cross_check",
      html_url: "https://github.com/blake-enyart"
    }

    repo = Repository.new(attrs)

    expect(repo).to be_a Repository
    expect(repo.name).to eq(attrs[:name])
    expect(repo.html_url).to eq(attrs[:html_url])
  end
end
