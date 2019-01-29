require 'rails_helper'

describe Repository do
  it "creates correctly" do
    hash = { html_url: "https://www.google.com",
      name: "Google"
    }

    repo = Repository.new(hash)

    expect(repo.url).to eq(hash[:html_url])
    expect(repo.name).to eq(hash[:name])
  end
end
