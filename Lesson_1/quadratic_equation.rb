#!/usr/bin/env ruby
puts 'Please enter the coefficients of a quadratic equation. Use "space" as a separator.'
data = gets.chomp
a, b, c = data.split(' ').map(&:to_f)

if a.zero?
  puts 'Not a quadratic equation!'
  return
end

D = b**2 - 4 * a * c

if D < 0
  puts 'No roots!'
elsif D.zero?
  puts "D = #{D}, x = #{(-b / (2 * a)).to_s}"
else
  puts "D = #{D}\nx1 = #{((-b + Math.sqrt(D)) / (2 * a)).to_s}\nx1 = #{((-b - Math.sqrt(D)) / (2 * a)).to_s}"
end
