require 'rails_helper'

RSpec.describe Repository do
  it 'has attributes' do
    attributes = {name: 'battleship',
                  html_url: 'wwww.example.com'}

    repo = Repository.new(attributes)

    expect(repo.name).to eq(attributes[:name])
    expect(repo.address).to eq(attributes[:html_url])
  end
end
