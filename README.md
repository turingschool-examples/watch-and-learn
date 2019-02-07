

# Brownfield of Dreams


Brownfield of Dreams is a Mod3 paired project at [Turing School of Software & Design](https://turing.io/) where 2 students with 14 weeks of experience in software development have to add on features to a pre-existing Ruby on Rails application by consuming GitHub's REST API, and integrate emails in Rails.

Students added the ability for a user to connect their GitHub account to the app, see a list of their repos, followers & followings. Students also added the functionality to invite other gitHub users to the app through an email invitation, and have that user create an account and activate their account after registration.

![Image description](https://i.imgur.com/FE8Y4Wt.png)


![Image description](https://i.imgur.com/sSXhWkF.png)


![Image description](https://i.imgur.com/yAbLZ9R.png)


### Active Brownfield of Dreams - app in Production:

https://frozen-depths-84537.herokuapp.com/

### Brownfield of Dreams - Github Repository:
https://github.com/bendelonlee/brownfield-of-dreams


### Brownfield of Dreams - Project Management Board:

We used Github Projects to manage the development of this app.  Checkout our board [here](https://github.com/bendelonlee/brownfield-of-dreams/projects/1).


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

#### Prerequisites:

* Install Ruby (Version 2.4.1)
* Install Rails (Version 5.2.2)
* Heroku Account - (Create free account [here](https://signup.heroku.com/) if you don't have on already.)
* SendGrid Account - (Create free account [here](https://signup.sendgrid.com/) if you don't have on already.)

#### Creating API Keys:
Brownfield utilizes the Youtube's & Github's REST API, so you will need to register and get an api key created with each of these services.
* [Github REST API Documentation](https://developer.github.com/v3/)
* [Github REST API Key Creation steps](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)


* [Youtube API Documentation](https://developers.google.com/youtube/)
* [Youtube API Key Creation steps](https://developers.google.com/youtube/registering_an_application)




#### Installing:

To run this application locally, clone this [repo](https://github.com/bendelonlee/brownfield-of-dreams) and follow the steps below:

1) Install gems:
```
$ bundle
```

2) Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

3) Create, migrate, & seed database:
```
$ rake db:{create,migrate,seed}
```

4) Start your rails server:
```
$ rails s
```


5) Open browser and navigate to:

```
localhost:3000
```


## Running the RSpec Test Suite

Brownfield has a full RSpec suite of feature and model tests for every piece of functionality in the app.

#### Running the Full Test Suite:

From the root of the directory, type the below command to run the full test suite:

```
$ rspec
```

#### Running only Feature Tests:

Type this command from the root of the directory.

```
$ rspec ./spec/features
```
#### Running only Model Tests:

Type this command from the root of the directory.

*Just change the file path to test mailers, facades, services & requests.*

```
$ rspec ./spec/models
```

#### Running a Single Test File:

Type this command from the root of the directory.

```
$ rspec ./spec/features/user/github/user_sees_github_info_spec.rb

```
#### Running a Single Test From a Single Test File:

Type this command from the root of the directory.

*Just change the line number in the command to run a different test in that file.*

```
$ rspec ./spec/features/user/github/user_sees_github_info_spec.rb:5
```


## Deployment

To deploy this app through Heroku as we have, you can follow these [instructions](https://devcenter.heroku.com/articles/git) on Heroku's website.

## Built With

* [Ruby - Version 2.4.1](https://ruby-doc.org/core-2.4.5/) - Base code language
* [Rails - Version 5.2.2](https://guides.rubyonrails.org/v5.1/) - Web framework used
* [Faraday](https://github.com/lostisland/faraday) - HTTP Client for API calls
* [RSpec](http://rspec.info/documentation/) - Testing Suite
* [Heroku](https://www.heroku.com/) - Used to deploy to production
* [Github Project Board](https://github.com/features/project-management/) - Used for project management tracking
* [SendGrid](https://sendgrid.com/) - Used to send emails from the app

## Additional Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

## Contributing

When contributing to this repository, please submit a pull request [here](https://github.com/bendelonlee/brownfield-of-dreams) and one of the authors will review the request and merge it into master if it looks good.

##### *** Please note, that we only believe in Test Driven Development, so if your code you push does not have the corresponding tests to go with it, it will be rejected!! *** #####

## Authors

* **Ben Lee** - *Team member* - [Ben's Github](https://github.com/bendelonlee)
* **Justin Mauldin** - *Team member* - [Justin's Github](https://github.com/justinmauldin7)


## Acknowledgments

* Thanks to our Mod3 instructors [Sal Espinosa](http://s-espinosa.github.io/) & [Mike Dao](https://github.com/mikedao) for all their help and insight on this project.

* Thanks to all our other fellow [Turing School of Software & Design](https://turing.io/) - Mod3 - Backend classmates that helped us on this project as well.
