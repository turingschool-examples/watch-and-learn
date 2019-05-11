require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  it 'It has attributes' do
    attributes = {
      login: 'george',
      html_url: 'jungle.com'
    }

    result = GithubUser.new(attributes)

    expect(result.username).to eq('george')
    expect(result.github_url).to eq('jungle.com')
  end
end
