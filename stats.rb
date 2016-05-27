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

all_id_of_tools = []

d.items.each do |t|
  if t.category.include? "Tools"
    all_id_of_tools.push t.id
  end
end

number_of_tools = 0
  t.transaction.each do |t|
    if all_id_of_tools.include? t.item_id
      number_of_tools += t.quantity
    end
  end

puts "We sold #{number_of_tools} items from the Tools category"
#-----------------------------------

id_price = {}
d.items.each do |i|
  id_price[i.id] = i.price
end

id_quantity = {}
t.transaction.each do |t|
  id_quantity[t.item_id] = t.quantity
end

total_revenue = 0
id_price.each do |id, price|
  total_revenue += price * id_quantity[id]
end

puts "Our total revenue was $#{total_revenue.round(2)}"

#questions

# * Harder: the highest grossing category was __
