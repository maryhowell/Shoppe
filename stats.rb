require "./item"
require "./user"
require "./data_parser"
require "./transaction_parser"
require "./transaction"

def file_path file_name
  File.expand_path "../data/#{file_name}.json", __FILE__
end

d = DataParser.new file_path("data")
t = TransactionParser.new file_path("transactions")

d.parse!
t.parse!

#Start stats -----------------
users_max = {}
users_max.default = 0

t.transaction.each do |x|
  users_max[x.user_id] = users_max[x.user_id] + 1
end

max = users_max.max_by {|u,v|v}
user_most_orders = ""
d.users.each do |a|
  if a.id == max.first
    user_most_orders = a.name
  end
end
puts "The user that made the most orders was #{user_most_orders}"
#--------------------

number_of_lamps = 0

t.transaction.each do |q|
  if q.item_id == 8
    number_of_lamps += q.quantity
  end
end

puts "We sold #{number_of_lamps} Ergonomic Rubber Lamps"
#------------------------------------

number_of_tools = 0
all_id_of_tools = {}

d.items.each do |t|
  if t.category == "Tools"
    all_id_of_tools
    binding.pry
  end
end







puts "We sold #{number_of_tools} items from the Tools category"



#questions
# * Our total revenue was __
# * Harder: the highest grossing category was __