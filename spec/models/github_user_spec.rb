require 'rails_helper'

RSpec.describe GithubUser, type: :model do
  it 'has attributes' do
    attributes = {
      login: "jamisonordway",
      html_url: "https://github.com/jamisonordway",
      id: "12345"
    }

    github_user = GithubUser.new(attributes)

    expect(github_user.name).to eq(attributes[:login])
    expect(github_user.address).to eq(attributes[:html_url])
    expect(github_user.id).to eq(attributes[:id])
  end

  describe 'Instance Methods' do
    it '#registered_user?' do
      attributes = {
        login: "jamisonordway",
        html_url: "https://github.com/jamisonordway",
        id: "12345"
      }

      github_user = GithubUser.new(attributes)

      create(:user, uid: '12345')

      expect(github_user.registered_user?).to eq(true)
    end

    it '#not_already_friend?' do
      attributes = {
        login: "jamisonordway",
        html_url: "https://github.com/jamisonordway",
        id: "12345"
      }

      github_user = GithubUser.new(attributes)

      friend = create(:user, uid: '12345')
      user = create(:user)

      create(:friendship, user: user, friend: friend)

      expect(github_user.not_already_friend?(user)).to eq(false)
    end
  end

end
