require 'rails_helper'

describe Repository do
  it 'has attributes' do
    attributes = {
      name: "Github Repo",
      html_url: "https://github.com/JaxJafinPapau/brownfield-of-dreams"
      }

    repository = Repository.new(attributes)
    expect(repository.name).to eq("Github Repo")
    expect(repository.url).to eq("https://github.com/JaxJafinPapau/brownfield-of-dreams")
  end

end
