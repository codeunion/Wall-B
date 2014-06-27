require 'data_mapper'

DataMapper.setup(:default, "sqlite:example.db")

class Wall
  include DataMapper::Resource
  property :id,          Serial
  property :created_by, String
  property :title, String
  property :description, Text
  property :likes, Integer
  property :created_at, DateTime
  property :favorite_ice_cream, String
end

class House
  include DataMapper::Resource
  property :id, Serial
  property :name, String
end

DataMapper.finalize
DataMapper.auto_upgrade!