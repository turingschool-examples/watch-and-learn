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
