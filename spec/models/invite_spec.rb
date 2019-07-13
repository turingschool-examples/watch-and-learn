# frozen_string_literal: true

class GithubUser
  attr_reader :name, :url, :uid
  def initialize(attributes)
    @name = attributes[:login]
    @url = attributes[:html_url]
    @uid = attributes[:id]
  end
end

require 'rails_helper'

RSpec.describe 'attributes' do
  it 'has attributes' do
    attributes = {
      login: 'name1',
      html_url: 'www.wat.com',
      id: 123
    }

    user = GithubUser.new(attributes)

    expect(user.name).to eq('name1')
    expect(user.url).to eq('www.wat.com')
    expect(user.uid).to eq(123)
  end

  it 'has different attributes' do
    attributes = {
      login: 'name2',
      html_url: 'www.wat.org',
      id: 456
    }

    user = GithubUser.new(attributes)

    expect(user.name).to eq('name2')
    expect(user.url).to eq('www.wat.org')
    expect(user.uid).to eq(456)
  end
end
