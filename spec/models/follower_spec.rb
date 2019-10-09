require 'rails_helper'

describe 'Follower' do
  before :each do
    @follower = Follower.new({login: 'bobross', html_url: 'example.com'})
  end

  it 'can initialize with a hash of user_name and url' do
    expect(@follower).to be_an_instance_of(Follower)
  end

  it 'has attributes user_name, url' do
    expect(@follower.user_name).to eq('bobross')
    expect(@follower.html_url).to eq('example.com')
  end
end
