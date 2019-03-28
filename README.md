# README

## Description

Brownfield of Dreams is a 10-day paired project assigned during the 3rd module in the Backend Engineering program at the Turing School of Software & Design. Students received an existing "brownfield" code base, located at https://github.com/turingschool-examples/brownfield-of-dreams/projects/1, which is for a Ruby on Rails application that organizes YouTube content for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags. A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

### Learning Goals

Students were tasked with building out additional functionality on top of the existing code. Features included:
- Incorporating GitHub's API to pull in data on the user's repos, following, and followers
- Implementing OAuth through GitHub and OmniAuth
- Building out an "Add Friends" social feature

The project was meant to teach the experience of taking over existing code, wrestling with previous design decisions, dealing with technical debt, prioritizing unanticipated issues, and selective refactoring. From a technical perspective, the project introduced students to:
- Consuming JSON APIs
- Authenticating via OAuth
- Sending email via Rails & SendGrid

## Schema
![Database Schema](app/assets/images/db_schema.png "Database Schema")

## Project Board

The team organized their work using the GitHub Project Board below. Not all stories were completed.
https://github.com/Mackenzie-Frey/brownfield-of-dreams/projects/1

## Local Setup

To set up Brownfield of Dreams in your local environment with full functionality, you'll need accounts and API keys for YouTube, GitHub, GitHub OAuth, and SendGrid (if you want to send emails). The team used Figaro to store keys inside an application.yml file. Wherever you choose to store your keys, they should be set to the following variables:

```
'ENV[YOUTUBE_API_KEY]' = your_youtube_key
'ENV[GITHUB_API_KEY]' = your_github_key
'ENV[GITHUB_OAUTH_CLIENT_ID]' = your_github_oauth_client_id
'ENV[GITHUB_OAUTH_CLIENT_SECRET]' = your_github_oauth_client_secret
'ENV[SENDGRID_PASSWORD]' = your_sendgrid_password
```

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Install and run MailCatcher, if you'd like to see test emails without sending real mail
```
$ gem install mailcatcher
$ mailcatcher
```
Go to http://localhost:1080/ to see your mail, when you send it

Run the test suite:
```
$ bundle exec rspec
```

## Built Utilizing
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
* [Ruby 2.4.1](https://www.ruby-lang.org/en/)
* [Rails 5.2.0](https://rubyonrails.org/)
* [RSpec](http://rspec.info/)
* [Pry](https://github.com/pry/pry)
* [FactoryBot](https://github.com/thoughtbot/factory_bot)
* [SimpleCov](https://rubygems.org/gems/simplecov/versions/0.12.0)
* [RuboCop](https://github.com/rubocop-hq/rubocop)
* [Postman](https://www.getpostman.com/)
* [GitHub Projects](https://github.com/features/project-management/)
* [GitHub](https://github.com/)
