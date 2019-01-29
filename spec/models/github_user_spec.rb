require 'rails_helper'


describe GithubUser do
  it "creates correctly" do
    hash = {
      html_url: "google.com",
      login: "mikedao"
    }
    guser = GithubUser.new(hash)

    expect(guser.url).to eq(hash[:html_url])
    expect(guser.handle).to eq(hash[:login])
  end
end
