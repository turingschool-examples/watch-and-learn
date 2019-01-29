require 'rails_helper'

describe "Repo model" do
  it "exists" do
    repo = Repo.new({})

    expect(repo).to be_a(Repo)
  end
  it 'has attributes' do
    repo = Repo.new({name: "Hey", html_url: "https://something.com"})

    expect(repo.name).to eq("Hey")
    expect(repo.url).to eq("https://something.com")
  end
end
