require 'rails_helper'

describe Follower do
  it 'has attributes' do
    attributes = {
      login: "Stoovles",
      html_url: "https://github.com/Stoovles"
      }

    repository = Follower.new(attributes)
    expect(repository.name).to eq("Stoovles")
    expect(repository.url).to eq("https://github.com/Stoovles")
  end

end
