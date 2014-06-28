require 'sinatra'
require 'data_mapper'

if ENV['RACK_ENV'] != "production"
  require 'dotenv'
  Dotenv.load '.env'
  DataMapper.setup(:default, "sqlite:wall.db")
end

if ENV['RACK_ENV'] == "production"
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

class Wall
  include DataMapper::Resource
  # See:
  #  * Properties user documentation: http://datamapper.org/docs/properties.html
  #  * Method documentation: http://rdoc.info/github/datamapper/dm-core/DataMapper/Model/Property:property
  property :id,          Serial
  property :created_by, String
  property :title, String
  property :description, Text
  property :likes, Integer
  property :created_at, DateTime
end

class Message
  property :created_at, DateTime
  property :likes, Integer
  property :content, Text
  property :created_by, String
  property :id, Serial
  property :wall_id, Serial
end

DataMapper.finalize
DataMapper.auto_upgrade!

get "/" do
  @walls = Wall.all
  # * User docs: http://datamapper.org/docs/find.html
  # * Method docs: http://rdoc.info/github/datamapper/dm-core/DataMapper/Collection#all-instance_method
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
  # * User Docs for Create: http://datamapper.org/docs/create_and_destroy.html
  # * Method docs for create: http://rdoc.info/github/datamapper/dm-core/DataMapper/Model#create-instance_method
  if @wall.saved?
    redirect "/"
  else
    erb :new_wall
  end
end

get '/walls/:id' do
  @wall = Wall.get(params[:id])
  erb :wall
end

get '/walls/:id/messages/new' do
  @wall = Wall.get(params[:id])
  @message = Message.new
  erb :new_message
end

post '/walls/:id/messages/new' do
  message_attributes = params["message"]
  
  message_attributes["created_at"] = Datetime.now
  @message = Message.create(message_attributes)
  redirect '/walls/:id'
end
