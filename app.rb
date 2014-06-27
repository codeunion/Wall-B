require 'sinatra'

# a wall has...
# a person it was created by, a title, a description, likes
# wouldn't it be nice to know when created and when edited?


# populate the 'wall'
def get_walls
  wall = []
  3.times do |n|
    wall.push({:created_by => "#{n} davison", :description => "for memes n stuff#{n}", :title => "3#{n} luve kittehs", :likes => n})
  end
  wall
end

# read
get "/" do
  @walls = get_walls
  erb :home
end

# create
get "/walls/new" do
  @wall = {}
  @walls = get_walls
  erb :new_wall
end

# update?
post "/walls" do
  @new_wall = params["wall"]
  @walls = []
  @walls.push @new_wall
  redirect "/"
end

# destroy

# put

# delete
