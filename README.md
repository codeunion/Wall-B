# Wall-B

In a world where communication is only allowed over "The Internet"; ONE
PROGRAMMER stands to make a "killr app".

Your mission? Create a website where people can create "Walls" anyone can add
messages on.

## Running the App

1. Fork and clone this repository
1. `bundle install --without development`
1. `cp .env.example .env`
1. `rerun -x rackup` # Watches your files and re-starts the app on save.

## Pushing to Production

1. Ensure you've [created a heroku account, installed the heroku toolbelt, and
   logged in to the heroku toolbelt on your machine.][heroku-quickstart]
1. `heroku create`
1. `git push heroku master`
1. `heroku open`

## Functional Requirements

1. A guest may create a wall with a name, description, and author - DONE
2. A guest may see a list of all walls by name - DONE
3. A guest may click on a walls to see its description - DONE
4. A guest may add a message to a wall
5. A guest may see all the messages on a wall

Not sure how to make this happen? The wiki should
[get you started](https://github.com/codeunion/wall-b/wiki/home)!

## STREEEEETTTCCCCHHH goals (For the over-achievers out there)

* A guest may use a shared secret to [encrypt][encryption-and-decryption] a message on a wall.
* A guest may use a shared secret to [decrypt][encryption-and-decryption]
* A guest may "like" a message
* A guest may tag a wall
* A guest may list only walls with a tag

## Core Concepts
1. Grouping [data][data] into your own [datatypes][datatypes] that represent
   'human' things.
1. Storing [data][data] submitted by an [http request][request] for later
   retrieval and presentation with a [database][database]
1. Creating [relationships][relational-databases] between [datatypes][datatypes] in
   your database.

[heroku-quickstart]:https://devcenter.heroku.com/articles/quickstart
[encryption-and-decyption]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#encryption
[data]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#data
[datatypes]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#datatypes
[request]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#request
[relational-databases]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#relational-databases
[database]:https://github.com/codeunion/web-fundamentals/wiki/Glossary#database
