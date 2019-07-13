# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubUser do
  describe 'attributes' do
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
end
