require 'rails_helper'

RSpec.describe Repository, type: :model do
  it 'It has attributes' do
    attributes = {
      name: "steve",
      svn_url: "ierbveibvljnasvrbvibrljvn.com"
    }
    result = Repository.new(attributes)

    expect(result.name).to eq("steve")
    expect(result.url).to eq("ierbveibvljnasvrbvibrljvn.com")
  end
end
