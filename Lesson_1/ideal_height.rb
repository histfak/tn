#!/usr/bin/env ruby
puts 'Please enter your name and height below. Use "space" as a separator.'
data = gets.chomp
name, height_s = data.split(' ')
height = height_s.to_i
if height - 110 < 0
  puts "Wow! #{name}, your weight is already ideal!"
else
  puts "#{name}, your ideal weight is #{height - 110}."
end
