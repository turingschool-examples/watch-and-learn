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

First you'll need to setup an API key with YouTube and have it defined within `ENV['YOUTUBE_API_KEY']`. There will be one failing spec if you don't have this set up.

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

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0


### DTR


Group Member Names: Zach Nager and Teresa Knowles

Project Expectations: What does each group member hope to get out of this project? 
-Strive for 4s but make sure we have 3s all across first. 
-Gain a solid understanding of working with APIs 
-Learn Oauth 
-Learn how to squash commits and Ruby style

Goals and expectations:
-Learn more things to a good level and not just one thing very well
	
Team strengths:
-Zach: happy to put in as much time as needed, high expectations
-Teresa: trying new things, taking risks, research
Look out for:
-Zach: asking others for help
-Teresa: Tend to go into "rabbit holes" trying to have additional features

How to overcome obstacles:
-Open communication
-Honest code reviews
-Keeping an open mind
-Ask for help when needed after struggling for a while


Schedule Expectations (When are we available to work together and individually?):
-Afternoon work, no early mornings
-Review any code from the night before every morning
-Sundays off or remote day
-Saturdays are work day
-Usually we can stay at school after classes are over, 6:30-7pm. Some days Teresa will have to go home sooner


Communication Expectations (How and often will we communicate? How do we keep lines of communication open?):
-Daily over slack and in person
-Late night messages are ok but might be answered the next day


Abilities Expectations (Technical strengths and areas for desired improvement):
Improvement:
-Teresa: Using TDD as a design tool
-Zach: Use declarative programming and keep OOP principles in mind
Strengths:
-Zach: Comfortable with Active Record and Ruby
-Teresa: Comfortable with MVC and routes

Workload Expectations (What features do we each want to work on?):
-Do the setup together and then divide the workload as needed


Workflow Expectations (Git workflow/Tools/Code Review/Reviewing Pull Requests): 
-Start out working as a pair and then reasses
-Making sure we don't overlap on work 
-Be clear on what you're working on 
-Never merge your own PR
-Comment on every PR


Expectations for giving and receiving feedback:
-Open feedback
-Be real


Agenda to discuss project launch:

Ideas:
 
Tools: 
-Use Github project 
-Learn more tools (Rubocop, Hound, etc)

Additional Notes:
