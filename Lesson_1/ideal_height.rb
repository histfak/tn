#!/usr/bin/env ruby
puts 'Please enter your name and height below. Use "space" as a separator.'
data = gets.chomp
name, height = data.split(' ')
if height.to_i - 110 < 0
  puts "Wow! #{name}, your height is already ideal!"
else
  puts "#{name}, your ideal height is #{height.to_i - 110}."
end
