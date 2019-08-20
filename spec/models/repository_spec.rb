require 'rails_helper'

describe Repository do
  it "exists" do
    attrs = {
      name: "Brownfield of Horrors",
    }

    repository = Repository.new(attrs)

    expect(repository).to be_a Repository
    expect(repository.name).to eq("Brownfield of Horrors")
  end
end
