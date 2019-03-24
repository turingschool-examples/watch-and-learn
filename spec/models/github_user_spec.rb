require 'rails_helper'

describe GithubUser do

  it 'exists' do
    follower = GithubUser.new({})

    expect(follower).to be_a(GithubUser)
  end

  it 'has attributes' do
    follower = GithubUser.new({login: 'login', html_url: 'url', id: 12})

    expect(follower.handle).to eq('login')
    expect(follower.url).to eq('url')
    expect(follower.uid).to eq(12)
  end

  describe 'instance_methods' do
    describe '.friendable?' do
      it 'returns a boolean if the user can be friended by the current_user' do
        @user = create(:github_user)
        @potential_friend = GithubUser.create({id: 41562392})
        allow_any_instance_of(ApplicationController).to (
          receive(:current_user).and_return(@user)
        )

        # User doesn't have an account
        expect(@potential_friend.friendable?).to eq(false)

        @potential_friends_account = create(:github_user, uid: 41562392)

        # User has an account and is not friends with the current_user
        expect(@potential_friend.friendable?).to eq(true)

        Friend.create(user: @user, friend_user: @potential_friends_account)
        Friend.create(friend_user: @user, user: @potential_friends_account)

        # User has an account, but is friends with the current user
        expect(@potential_friend.friendable?).to eq(false)
      end
    end
  end
end
