require 'sinatra'

require 'data_mapper'
DataMapper.setup(:default, "sqlite:scratch.db")

class Wall
  include DataMapper::Resource
  property :id,          Serial
  property :created_by, String
  property :title, String
  property :description, Text
  property :likes, Integer
  property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
  @walls = Wall.all
  erb :home
end

get "/walls/new" do
  @wall = Wall.new
  erb :new_wall
end

post "/walls" do
  wall_attributes = params["wall"]
  wall_attributes["created_at"] = DateTime.now
  @wall = Wall.create(wall_attributes)
  if @wall.saved?
    redirect "/"
  else
    erb :new_wall
  end
end

# put

# delete
