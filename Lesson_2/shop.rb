#!/usr/bin/env ruby
cart = {}
sum = 0.0
loop do
  print 'Please enter the title of the item or "stop" to break: '
  title = gets.chomp
  break if title == 'stop'
  print 'price: '
  price = gets.chomp.to_f
  print 'quantity: '
  quantity = gets.chomp.to_f
  cart[title] = { 'price' => price, 'quantity' => quantity }
end

cart.each { |name, hash| sum += hash['price'] * hash['quantity'] }

puts cart
puts "Total: #{sum}"
