# Brownfield Of Dreams

## Background and Description

This is the base repo for a brownfield project used at Turing for Backend Mod 3. Building on top of existing code presents a different set of challenges. Technical debt and the decisions of the past frequently present unanticipated challenges. Understanding how your decisions impact a team is an important part of learning how to write maintainable software.

This is a Ruby on Rails application used to organize YouTube content used for
online learning. Learning goals from this project were to build on top of brownfield code, consume a JSON API, authenticate users with OAuth, send emails from an application, and configure continuous integration.

<p align="center">
  <a href="https://secure-fjord-62840.herokuapp.com/">View our Brownfield of Dreams</a>
 </p>

### Team
<p>
<a href="https://github.com/arpariseau">Alex Pariseau</a>
</p>
<p>
<a href="https://github.com/janegreene">Jane Greene</a>
</p>

* [DTR Document](https://gist.github.com/janegreene/b1a60f606e61b24d9be6d5d7576c9396)

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [TravisCI](https://travis-ci.org/)

### Ruby Version & Gems
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Ruby_logo.svg/200px-Ruby_logo.svg.png" alt="Ruby Logo" width="20" height="20"/> v2.5.3
- <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Ruby_On_Rails_Logo.svg/200px-Ruby_On_Rails_Logo.svg.png" alt="Rails Logo" width="60" height="20" /> v5.2.4

- rspec-rails
- capybara
- launchy
- pry
- simplecov
- shoulda-matchers
- factory_bot_rails
- orderly
- vcr
- webmock
- faker
- rubocop
- figaro

# Getting Started

## Installing

#### Clone repository:
```javascript
git clone git@github.com:janegreene/brownfield_of_dreams.git
```
#### Install gems:
```javascript
bundle install
```
#### Configure databases:
```javascript
rails db:{create,migrate,seed}
```
#### Fire up local server: (http://localhost:3000)
```javascript
rails s
```
#### Run test suite:
```javascript
bundle exec rspec
```

## User Roles

1. Visitor - this type of user is unable to view classroom content or use bookmarks
2. User - this user is registered and logged in to the application. They can view all
content and bookmark videos of interest. They can also add friends and see github
related dashboard features like followers, followings, and repos. Users can also
send emails to their friends to join the site.
3. Admin User - this user can add new tutorial content and upload YouTube playlists.
---

 ### If you are interested in contributing:
- Fork repo (https://github.com/janegreene/brownfield-of-dreams)
- Create your feature branch (`git checkout -b feature/fooBar`)
- Commit your changes (`git commit -m 'Add some fooBar'`)
- Push to the branch (`git push origin feature/fooBar`)
- Create a new Pull Request
