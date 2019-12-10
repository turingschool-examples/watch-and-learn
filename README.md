# Brownfield Of Dreams

## Description
Brownfield of Dreams is a responsive Ruby on Rails application that allows users to make accounts and add videos from the YouTube API and to a tutorial. Registered users can then connect their accounts via the GitHub Oauth process to display a list of their GitHub followers and individuals they are following on GitHub. If both the user and the GitHub follower/followed have accounts in our program, then the user has the option to add the GitHub follower/followed as a friend in our app.

The project was completed as a three person team over a 10-day sprint. Our team inherited the project base-code (a brownfield project) and built out the features seen in the final codebase.

## Purpose
Object Oriented Programing principles, Restful Routing, Database Management, Test Driven Development, Behavior Driven Development, Authenticated API calls, Oauth process

## Installation
1. Clone down the repo into a directory of your choice
```
  git clone https://github.com/zacisaacson/brownfield-of-dreams
```
1. Change into the directory
```
  cd brownfield-of-dreams
```
1. Install the gem packages
```
  bundle install
```
1. Install node packages for stimulus
```
  brew install node
  brew install yarn
  yarn add stimulus
```
1. Set up the database
```
  rake db:create
  rake db:migrate
  rake db:seed
```
1. Launch your local server (after ensuring the requirements below are met)
```
  rails s
```

## Requirements
Environment variables and required API keys/tokens:
1. YouTube API key defined as `ENV['YOUTUBE_API_KEY']`
1. GitHub Token defined as `ENV['GITHUB_TOKEN_1']`
1. A second GitHub Token defined as `ENV['GITHUB_TOKEN_2']`
1. GitHub client_id defined as `ENV['GITHUB_CLIENT_ID']`
1. GitHub client_secret defined as `ENV['GITHUB_SECRET_ID']`

## Focus Areas

## Technologies / Framework
The following technologies were used for this project:
* [stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
* [webpacker](https://github.com/rails/webpacker)
* [faraday](https://github.com/lostisland/faraday)
* [figaro](https://github.com/laserlemon/figaro)
* [bootstrap](https://getbootstrap.com/)
* [omniauth](https://github.com/omniauth/omniauth)
* [google-api-client](http://chromedriver.chromium.org/)

## Screenshots

## Database / Schema Diagram

## User Roles
1. Visitor - a visitor is any user of our page without an account. Visitors can view tutorials but cannot bookmark them until they have created an account.
1. Registered User - a registered user is a user who has signed up for an account with us. These users can view tutorials, connect. Regular users will receive a validation email and can be updated to validated users when they confirm that email.
1. Admin - an admin user is a user who is logged in as an administrator role. These users have access to an administrator dashboard where they can create, edit, and delete new tutorials. An administrator user does not have the ability to connect to GitHub or to create a friend list from their GitHub followers/followed.

## Testing

### Testing Technologies
* [rspec](https://github.com/rspec/rspec)
* [rubocop](https://github.com/rubocop-hq/rubocop)
* [factory_bot_rails](https://github.com/rubocop-hq/rubocop)
* [faker](https://github.com/faker-ruby/faker)
* [pry](https://github.com/pry/pry)
* [capybara](https://github.com/teamcapybara/capybara)
* [launchy](https://github.com/copiousfreetime/launchy)
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
* [simplecov](https://github.com/colszowka/simplecov)
* [vcr](https://github.com/vcr/vcr)
* [webmock](https://github.com/bblimke/webmock)
* [mailcatcher](https://mailcatcher.me/)

### Running Tests
Run the full test suite:
```
$ bundle exec rspec
```

Run a single test file
```
$ bundle exec rspec <path-to-file>
```

### Refreshing VCR Test Cassettes
From time to time you may receive an error when testing with the VCR. You can delete the cassettes directory from your `spec` folder and run `bundle exec rspec` to refresh the cassettes used. More information on VCR cassettes can be found in the [VCR documentation](https://github.com/vcr/vcr).

## Versions
- Ruby 2.4.1
- Rails 5.2.0
