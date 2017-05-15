#!/usr/bin/env ruby
puts 'Please the base and height of a triangle below. Use "space" as a separator.'
data = gets.chomp
base, height = data.split(' ').map(&:to_f)
puts "The area of a triangle is: #{0.5 * base * height}"
