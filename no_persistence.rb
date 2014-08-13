require 'sinatra'

WALLS_DB = []

def populate_walls
  3.times do |n|
    WALLS_DB.push({:created_by => "someone#{n}", :description => "for memes n stuff#{n}", :title => "Reddit Stuff ##{n}", :likes => n})
  end
end

populate_walls

def get_walls
  WALLS_DB
end

def add_new_wall wall_from_params
  WALLS_DB.push wall_from_params
end

# read
get "/" do
  @walls = get_walls 
  erb :home
end

# capture information from the user
get "/walls/new" do
  @walls = get_walls
  erb :new
end

# create the resource
post "/walls" do
  new_wall = params["wall"]
  add_new_wall new_wall 
  redirect "/"
end
