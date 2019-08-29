require 'rails_helper'

RSpec.describe Following do
  it 'exists' do
    attrs = {
      login: "Jo Bob",
      html_url: "google.com"
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq(attrs[:login])
    expect(following.html_url).to eq(attrs[:html_url])
  end
end

RSpec.describe '#instance methods' do
  it "github_user?" do
    attrs = {
      login: "ryanmillergm",
      html_url: "https://github.com/ryanmillergm"
    }

    follower = Follower.new(attrs)

    expect(follower.github_user?).to be_falsy
  end
end
