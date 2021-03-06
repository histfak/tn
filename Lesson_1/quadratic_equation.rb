#!/usr/bin/env ruby
puts 'Please enter the coefficients of a quadratic equation. Use "space" as a separator.'
data = gets.chomp
a, b, c = data.split(' ').map(&:to_f)

if a.zero?
  puts 'Not a quadratic equation!'
  exit
end

D = b**2 - 4 * a * c

if D < 0
  puts 'No roots!'
elsif D.zero?
  puts "D = #{D}, x = #{(-b / (2 * a))}"
else
  sqrt = Math.sqrt(D)
  puts "D = #{D}\nx1 = #{((-b + sqrt) / (2 * a))}\nx1 = #{((-b - sqrt) / (2 * a))}"
end
