require 'rails_helper'

RSpec.describe Follower do
  it "instantiates with name and url and github_id" do
    follower = Follower.new(name: 'follower name', url: 'test_url.com', id: '123455')
    expect(follower).to be_instance_of(Follower)
    expect(follower.name).to eq('follower name')
    expect(follower.url).to eq('test_url.com')
    expect(follower.github_id).to eq('123455')
  end

  describe 'methods' do
    describe 'instance_methods' do
      describe 'exists_as_user' do
        before :each do
          @follower_1 = Follower.new(name: 'follower name', url: 'test_url.com', id: '123455')
          @follower_2 = Follower.new(name: 'follower name', url: 'test_url.com', id: '123423')
          user = create :user, github_id: '123455'
        end

        it 'returns true if follower is in our system as a user' do
          expect(@follower_1.exists_as_user?).to be true
        end

        it 'returns false if follower is not in our system as a user' do
          expect(@follower_2.exists_as_user?).to be false
        end
      end
    end
  end
end
