require 'rails_helper'

describe Repo do
  scenario "exists", :vcr do
    attrs = {
      name: "Battleship",
      html_url: "https://github.com/zacisaacson/monster_shop"
    }
    repo = Repo.new(attrs)
    expect(repo).to be_a Repo
    expect(repo.name).to eq("Battleship")
    expect(repo.html_url).to eq("https://github.com/zacisaacson/monster_shop")
  end
end
