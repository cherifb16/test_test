require_relative "shopping_app/seller"
require_relative "shopping_app/item"
require_relative "shopping_app/customer"

seller = Seller.new("DIC store")
10.times{ Item.new("CPU", 40830, seller) }
10.times{ Item.new("Memory", 13880, seller) }
10.times{ Item.new("Motherboard", 28980, seller) }
10.times{ Item.new("Power Supply Unit", 8980, seller) }
10.times{ Item.new("PC Case", 8727, seller) }
10.times{ Item.new("3.5 HDD", 10980, seller) }
10.times{ Item.new("2.5 SSD", 13370, seller) }
10.times{ Item.new("M.2 SSD", 12980, seller) }
10.times{ Item.new("CPU Cooler", 13400, seller) }
10.times{ Item.new("Graphic Board", 23800, seller) }

puts "🤖 What is your name?"
customer = Customer.new(gets.chomp)

puts "🏧 Please enter the amount you want to charge to your wallet."
customer.wallet.deposit(gets.chomp.to_i)

puts "🛍️ Start shopping"
end_shopping = false
while !end_shopping do
  puts "📜 Products list"
  seller.items_list

  puts "️️️⛏ Please enter the item number"
  number = gets.to_i

  puts "⛏ Please enter the item quantity"
  quantity = gets.to_i

  items = seller.pick_items(number, quantity)

  items&.each{|item| customer.cart.add(item) }

  puts "🛒 Cart contents"
  customer.cart.items_list
  puts "🤑 Total amount: #{customer.cart.total_amount}"

  puts "😭 Do you want to finish shopping? (yes/no)"
  end_shopping = gets.chomp == "yes"
end

puts "💸 Would you like to finalize your purchase? (yes/no)"
customer.cart.check_out if gets.chomp == "yes"

puts "Highlighted items ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈ Result ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈ assorted cart.check_out"
puts "🛍️️ #{customer.name}'s possession"
customer.items_list
puts "😱👛 #{customer.name}'s wallet balance: #{customer.wallet.balance}"

puts "📦 #{seller.name}'s stock status"
seller.items_list
puts "😻👛 #{seller.name}'s wallet balance: #{seller.wallet.balance}"

puts "🛒 Cart contents"
customer.cart.items_list
puts "🌚 Total amount: #{customer.cart.total_amount}"

puts "🎉 Finish"
