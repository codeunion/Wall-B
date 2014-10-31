require 'sinatra'
require 'data_mapper'


DataMapper::Logger.new(STDOUT, :debug)


if ENV['RACK_ENV'] != "production"
  require 'dotenv'
  Dotenv.load('.env')
  DataMapper.setup(:default, "sqlite:wall.db")
end


if ENV['RACK_ENV'] == "production"
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

# Here we're telling DataMapper to connect to the database specified by our
# environment configuration.
#
# Heroku creates a postgres database and prepopulates our environment
# configuration in production just because we included the `pg` gem in our
# Gemfile. HOORAY!


# Below, we're defining a custom `datatype` to represent a `Wall`. Custom data
# types that represent the problem domain you're working in are called `models`.

def show_params
  p params
end


class Wall
  # `class` is a keyword for defining custom `datatypes`. These data types can
  # include data and methods.
  #
  # Custom data types are often built on top of and/or compose existing data
  # types.
  #
  # Remember! `String`, `Array`, `Fixnum` (i.e. whole numbers), `Float`, (i.e.
  # decimal numbers), `Hash`, etc. are datatypes you've been using all along.
  # These common data types are used across many langauges; though they may have
  # slightly different names and methods.

  include DataMapper::Resource
  # `include` is a way to say that your `Wall` is a "kind of"
  # `DataMapper::Resource`. In other words, we're building our `Wall` "on top
  # of" the `DataMapper::Resource`.
  #
  # This is an example of building "on top of" another data type. Every data
  # type built on top of `DataMapper::Resource` comes with a bunch of additional
  # methods for storing and retrievig data with a database.


  # We're going to declare what *additional* data a `Wall` is composed of, and
  # what those `data types` are. We do this with the `property` method, kindly
  # provided to us when we `include DataMapper::Resource`.
  #
  # See:
  #  * Properties user documentation: http://datamapper.org/docs/properties.html
  #  * Method documentation: http://rdoc.info/github/datamapper/dm-core/DataMapper/Model/Property:property

  property :id,          Serial
  # The `id` is a unique identifier for the wall. Think of it as a "Social
  # Security Number" for our walls. By using the `Serial` datatype we ensure
  # this property is unique for every single wall we insert into our database.

  property :created_by, String
  # Here we can store the name of the person who created the wall. `String`
  # properties can only be 255 characters long; so only use them when you don't
  # need to store a lot of words.


  property :title, String
  # This is a human-friendly name for the wall. We'll use it on the index page;
  # as well as the header of the wall page.

  property :description, Text
  # A bit more detail about a wall. `Text` properties can be several sentences
  # (or pages!) long; giving users the freedom to describe what the wall is for
  # to their hearts content.

  property :likes, Integer
  # Let's keep track of how many people click a "Like" button for a wall. To do
  # that, we want to use the `Integer` datatype.

  property :created_at, DateTime
  # This will let us record exacty when a wall is created.

  has n, :message

end

class Message
  include DataMapper::Resource

  property :id, Serial
  property :body, String
  property :likes, Integer, :default => 0
  belongs_to :wall
end






# PHEW! That's a lot of new ideas! But don't worry; you'll get it! Understanding
# programming takes practice!


DataMapper.finalize()
DataMapper.auto_upgrade!()

# These two lines tell DataMapper that you've defined all your models; and to
# prepare the database for writing and reading. It also makes sure the databases
# `schema` (or "structure" or "shape") matches the `DataMapper::Resource`s
# you've defined above.

get("/") do
  walls = Wall.all()
  # `all` is a method provided when we `include DataMapper::Resource`. It lets
  # us retrieve every `Wall` record in our database!
  # See:
  # * User docs: http://datamapper.org/docs/find.html
  # * Method docs: http://rdoc.info/github/datamapper/dm-core/DataMapper/Collection#all-instance_method
  body(erb(:home, :locals => {:walls => walls}))
end

get("/walls/description") do
  show_params
  wall_id = params["wall.id"]

  wall = Wall.get(wall_id)


  body(erb(:description, :locals => {:wall => wall}))
end

get("/walls/delete/:id") do
  show_params
  wall = Wall.get(params[:id])
  created_by = params[:created_by]
  body(erb(:delete, :locals=>{:wall=> wall,:created_by=>created_by}))
end


get("/walls/new") do
  wall = Wall.new()
  # We're going to create a new wall, since `views/new_wall.erb` requires a
  # `@wall` instance variable to auto-fill in the form.
  body(erb(:new_wall, :locals => {:wall => wall}))
end

get("/walls/update-form/:id") do
  show_params
  wall = Wall.get(params[:id])
  created_by_guess = params[:created_by_guess]
  body(erb(:edit_request, :locals => {:wall => wall,:created_by_guess=>created_by_guess}))
end


get("/walls-dynamic/description/:id") do
  show_params

  wall = Wall.get(params[:id])

  body(erb(:description, :locals => {:wall => wall}))
end


delete("/walls/:id") do
  show_params
  wall = Wall.get(params[:id])
  created_by = params[:created_by]
  if created_by == wall[:created_by]
    wall.destroy
    body(erb("Wall \"#{wall_attributes["title"]}\" has been deleted."
  ))
  else
    body("The author name you've submitted is not the author of this wall.</br></br>This wall has not been deleted.")
  end
  sleep(2)
  redirect("/")
end

post("/likes") do
  show_params
#  wall_attributes = params().fetch("wall")
#  wall = Wall.get(wall_attributes["id"])  Alternate Method
  wall = Wall.get(params[:wall][:id])
  wall.likes += 1
  wall.save
  body(erb("This wall now has <%= wall.likes %> \'Likes\' ", :locals => {:wall => wall}))
  sleep(2)
  redirect("/")


end

post("/:wall_id/messages") do
  show_params
  wall = Wall.get(params[:wall_id])
  wall.message = Message.create(:body => params[:message][:body])
  body(erb("The message <%= message.body %> has been added to Wall \'<%= wall.title %> \'", :locals => {:wall=>wall,:message=>message}))
  sleep(2)
  redirect("/")

end

post("/message/:id/likes") do
  show_params
  message = Message.get(params[:id])
  message.likes += 1
  message.save
  body(erb("This message now has <%= message.likes %>\'Likes\'", :locals => {:message=> message}))
  sleep(2)
  redirect("/")
end


post("/update-check") do
  show_params
  wall_attributes = params().fetch("wall")
  created_by_guess =  params["created_by_guess"]
  if created_by_guess == wall_attributes["created_by"]
    wall = Wall.get(wall_attributes["id"])
    body(erb(:edit_wall, :locals=>{:wall=>wall}))
  else
    body("The author name you've submitted is not
      the author of this wall.</br></br>You cannot update this wall.")
    sleep(2)
    redirect("/")
  end
end

post("/update") do
  show_params
  wall_attributes = params().fetch("wall")
  wall = Wall.get(wall_attributes["id"])
  wall.title = wall_attributes[:title]
  wall.description = wall_attributes[:description]
  wall.save
  body(erb(:updated_wall,:locals => {:wall=>wall}))
end

post("/walls") do
  wall_attributes = params().fetch("wall")
  # We'll get the starting attributes for this wall from `params` that came in
  # from `views/new_wall.erb`

  wall_attributes["created_at"] = DateTime.now()
  # And add in the `created_at` attribute with the current time.

  @wall = Wall.create(wall_attributes)
  # Now we'll *create a wall* in our database from these attributes!
  # See:
  # * User Docs for Create: http://datamapper.org/docs/create_and_destroy.html
  # * Method docs for create: http://rdoc.info/github/datamapper/dm-core/DataMapper/Model#create-instance_method

  if @wall.saved?()
    redirect("/")
    # If we successfuly create the wall, let's send the user back home.
  else
    body(erb(:new_wall))
    # If we *can't* create the wall; We'll redisplay the form so the user can
    # fix any errors.
  end
end
