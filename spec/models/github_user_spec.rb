require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  it 'has attributes' do
    attributes = {
      login: "jamisonordway",
      html_url: "https://github.com/jamisonordway"
    }

    github_user = GithubUser.new(attributes)

    expect(github_user.name).to eq(attributes[:login])
    expect(github_user.address).to eq(attributes[:html_url])
  end
end
