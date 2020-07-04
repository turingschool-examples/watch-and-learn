require 'rails_helper'

describe Repo do
  it "exists" do
    attrs = {
      id: 1,
      name: "adopt_dont_shop",
      html_url: "http://www.pets.com",
    }
    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.id).to eq(1)
    expect(repo.name).to eq("adopt_dont_shop")
    expect(repo.html_url).to eq("http://www.pets.com")
  end
end
