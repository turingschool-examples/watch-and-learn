require "rails_helper"

RSpec.describe Repository, type: :model do
  it 'exists' do
    rep = Repository.new({})
    expect(rep).to be_a(Repository)
  end
  it 'has name and url attributes' do
    rep = Repository.new({name: "bla", html_url: "http://www.website.com"})
    expect(rep.name).to eq("bla")
    expect(rep.url).to eq("http://www.website.com")
  end
end
