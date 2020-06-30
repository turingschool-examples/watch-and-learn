# Brownfield Of Dreams

This is the base repo for a brownfield project used at Turing for Backend Mod 3.

Project Spec and Evaluation Rubric: https://github.com/turingschool-examples/brownfield-of-dreams

### Project Board

Students will continue to build on the existing code base using the cards within the following Github Project: https://github.com/turingschool-examples/brownfield-of-dreams/projects/1

**Learning Goals and Labels**

The cards are labeled in a way that correspond to learning goals or to specific areas you might personally want to focus on.

Cards should be completed from top to bottom in the To Do column. Cards labeled `good first issue` are good as filler work and will allow you to practice common Rails skills.

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup

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
$ yarn
```

Set up the database
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

### Youtube API

This project makes use of the Youtube API.

First, obtain an API key by following steps 1 - 3 in [this guide](https://developers.google.com/youtube/v3/getting-started) for the "Before you Start" section. When creating new credentials, make sure you choose the "API Key" option. Make sure that you follow the step to enable the Youtube Data API. Your API key will not work without that step.

Once you have obtained an API key and enabled the API:

1. Run `bundle exec figaro install`
1. This will create the file `config/application.yml`. Open that file.
1. Append the following to that file: `YOUTUBE_API_KEY: <your api key>`, `replacing <your api key>` with the api key you just obtained.

## Test Suite

You can run the test suite with:

```ruby
$ bundle exec rspec
```

If set up correctly, and assuming you have internet access and the Youtube API is functioning correctly, you should have all passing tests.

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.5.3
* Rails 5.2.0
