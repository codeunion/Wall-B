require 'sinatra'

require 'data_mapper'
DataMapper.setup(:default, "sqlite:walls.db")

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

def show_params
  p "params are #{params}"
end

# read
get "/" do
  @walls = Wall.all
  erb :homedb
end

# create
get "/walls/new" do
  @wall = Wall.new
  @walls = Wall.all
  erb :new_walldb
end

post "/walls" do
  wall_attributes = params["wall"]
  wall_attributes["created_at"] = DateTime.now
  @wall = Wall.create(wall_attributes)
  if @wall.saved?
    redirect "/"
  else
    erb :new_walldb
  end
end

get "/walls/:id" do
  p params
  @wall = Wall.get(params[:id])
  erb :showdb
end

# update
put "/walls/edit/:id" do
  show_params
  @wall = Wall.get(params[:id])
  p "wall is #{@wall}"
  @wall.update(params[:wall])
  redirect "/"
end

# order here is actually important...

get "/walls/edit/:id" do
  @walls = Wall.all
  @wall = Wall.get(params[:id])
  erb :editdb
end


delete "/wall/:id" do
  @wall = Wall.get(params[:id])
  @wall.destroy
  redirect "/"
end


# delete
