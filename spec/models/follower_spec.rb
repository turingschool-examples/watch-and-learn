require 'rails_helper'

RSpec.describe Follower do
  it "instantiates with name and url" do
    follower = Follower.new(name: 'follower name', url: 'test_url.com')
    expect(follower).to be_instance_of(Follower)
    expect(follower.name).to eq('follower name')
    expect(follower.url).to eq('test_url.com')
  end
end
