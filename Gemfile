# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
# gem 'uglifier', '>= 1.3.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'

gem 'webpacker', '~> 3.5'

gem 'active_model_serializers'
gem 'acts-as-taggable-on', '~> 6.0'
gem 'factory_bot_rails'
gem 'faker'
gem 'faraday'
gem 'figaro'
gem 'google-api-client'
gem 'jquery'
gem 'omniauth-census', git: 'https://github.com/turingschool-projects/omniauth-census'
gem 'omniauth-google-oauth2'
gem 'omniauth-github'
gem 'will_paginate'
gem 'yt', '~> 0.29.1'

group :development, :test do
  gem 'awesome_print'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'foundation-rails'
  gem 'launchy'
  gem 'pry'
  gem 'rspec-rails'
  gem 'rubocop', '~> 0.72.0', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
