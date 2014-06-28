Links to see my site up and running:

1) Rackspace server + ngrok: http://maxpleaner-sinatra.ngrok.com/

2) Heroku: http://arcane-retreat-6837.herokuapp.com/



## Functional Requirements

- DONE 1. A guest may create a wall with a name,description, and author 
- DONE 2. A guest may see a list of all walls by name 
- DONE 3. A guest may click on a walls to see its description 
4. A guest may destroy a wall; but only when they provide the correct author name
5. A guest may update a wall with a new title, description; but only when they provide the correct author name

Not sure how to make this happen? The wiki should
[get you started](https://github.com/codeunion/wall-b/wiki/home)!

## STREEEEETTTCCCCHHH goals (For the over-achievers out there)

* A guest may "like" a message
* See number of likes
DONE *. A guest may add a message to a wall
* Can like messages
DONE *. A guest may see all the messages on a wall
* A guest may use a shared secret to [encrypt][encryption-and-decryption] a message on a wall.
* A guest may use a shared secret to [decrypt][encryption-and-decryption]
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
