require 'rails_helper'

RSpec.describe Follower do
  it 'exists' do
    attrs = {
      login: "ryanmillergm",
      html_url: "https://github.com/ryanmillergm"
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq(attrs[:login])
    expect(follower.html_url).to eq(attrs[:html_url])
  end
end
