# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repo do
  describe 'attributes' do
    it 'has attributes' do
      attributes = {
        name: 'name1',
        full_name: 'full_name1'
      }

      repo = Repo.new(attributes)

      expect(repo.name).to eq('name1')
      expect(repo.url).to eq('https://github.com/full_name1')
    end

    it 'has different attributes' do
      attributes = {
        name: 'name2',
        full_name: 'full_name2'
      }

      repo = Repo.new(attributes)

      expect(repo.name).to eq('name2')
      expect(repo.url).to eq('https://github.com/full_name2')
    end
  end
end
