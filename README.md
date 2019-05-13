# Brownfield Of Dreams

This is a Turing School of Software and Design Module 3 Backend Project.

This project is designed as a way for Turing students to gain experience in working with pre-existing codebases and understanding the desicions and generated tech-debt of developers in a realworld setting where sometimes making something work is more important than making it looks good.

Brown Field of Dreams was completed by:

 * [Vincent Provenzano](https://github.com/Vjp888)
 * [Trevor Nodland](https://github.com/tnodland)

**[See This Project Live!](https://brown-field-of-dreams.herokuapp.com/)**

### Project Board

See our workflow [here](https://github.com/Vjp888/brownfield-of-dreams/projects)

Each of the cards were labled with a general user feature and direction. We made the adjustment to the board to include a 'Deployed' tab to make organization of what was in production and what was waiting deployment easier to manage.

**Learning Goals and Labels**

What we hoped to learn:

  * Building on top of an existing codebase
  * Making API calls to Authenticated sources
  * Formatting API data into usable information
  * Handling OAuth securely
  * Generating and sending Email data with Rails
  * Gain a better understanding and empathy for the reason why technical debt accrues
  * Prioritization by working only on relevant code
  * Working with enviromental variables to santize and protect sensitive data

### About the Project

This is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

## Local Setup

### Required API keys
In order to run this application locally or live you will need a series of API keys, those keys include:

  * YouTube API with _YouTube Data APIv3_ active. [You can the Console here](https://console.developers.google.com)
  * A GitHub OAuth application [You can create one here](https://github.com/settings/developers)
  * To Run the test suite you will need **two** personal access tokens [created here](https://github.com/settings/tokens)
  * To Run live you will need a sendgrid username and password [Create one here](https://sendgrid.com/) locally you can run tests with MailCatcher

#### Initial setup

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
```

```
$ brew install yarn
```

```
$ yarn add stimulus
```

*Note* If Yarn give you an error you can attempt to run
```$ rm yarn.lock && yarn``` then run ```$ yarn add stimulus``` the issue should resolve

Set up the database
```
$ rake db:{create,migrate,seed}
```

Run Figaro
```
figaro install
```

Set API keys in  ```app/config/application.yml```

  * `YOUTUBE_API_KEY` - Uses the Youtube API key
  * `GITHUB_TOKEN_KEY` - Uses your personal Token (Only needed for testing)
  * `GITHUB_ID` - Uses the OAuth App Client ID
  * `GITHUB_SECRET` - Uses the OAuth App Client Secret
  * `GITHUB_FREIND_TOKEN` - A secondary personal token (Only needed for testing)
  * `SENDGRID_USERNAME` - Needed for live production to send activation and invitation emails
  * `SENDGRID_PASSWORD` - Needed for live production to send activation and invitation emails

  Once those keys are set you will be able to run the test suite with the included cassettes from VCR

  **If running locally/testing** Run ```mailcatcher``` to capture outgoing mail

  run ```bundle exec rspec```







## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)
* [omniauth-github](https://github.com/omniauth/omniauth-github)
* [rspec-rails](https://github.com/rspec/rspec-rails)
* [rubocop](https://github.com/rubocop-hq/rubocop)
* [mailcatcher](https://mailcatcher.me/)
* [hashids](https://hashids.org/ruby/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
