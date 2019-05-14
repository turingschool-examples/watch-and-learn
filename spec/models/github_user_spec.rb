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
  context 'instance methods' do
    it '.linked_github?' do
      attributes = {
        login: 'george',
        html_url: 'jungle.com'
      }

      attributes2 = {
        login: 'bill',
        html_url: 'jungle.com'
      }

      github_user = GithubUser.new(attributes)
      github_user2 = GithubUser.new(attributes2)
      user = create(:user, github_name: 'george')

      expect(github_user.linked_github?).to eq(true)
      expect(github_user2.linked_github?).to eq(false)
    end
  end
end
