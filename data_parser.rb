require 'pry'
require "json"

class DataParser

attr_reader :path, :users, :items, :content

  def initialize path
    @path = path
    @users = []
    @content = JSON.parse(File.read path)
    @items = []

  end

  def parse!
    content["users"].each do |user|
          # binding.pry
      @users.push(User.new user.values[0], user.values[1], user.values[2])
    end
    content["items"].each do |item|
      @items.push(Item.new item.values[0], item.values[1], item.values[2], item.values[3])
    end
  end

end
