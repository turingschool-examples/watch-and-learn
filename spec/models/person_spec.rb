require 'rails_helper'

RSpec.describe Person do

  before :each do
    @person = Person.new({
      login: 'garth',
      html_url: 'www.google.com'
      })
  end

  it "exists" do
    expect(@person).to be_a Person
  end

  it "has attributes" do
    expect(@person.name).to eq('garth')
    expect(@person.link).to eq('www.google.com')
  end
end
