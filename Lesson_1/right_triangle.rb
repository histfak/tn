#!/usr/bin/env ruby
puts 'Please enter the sides of the triangle below. Use "space" as a separator.'
data = gets.chomp
sorted = data.split(' ').map(&:to_f).sort
raise 'Wrong arguments' if sorted.size != 3
# could also be extracted using "a, b, c = sorted[0..2]"
c = sorted.pop # the longest side
a = sorted.pop
b = sorted.pop
unless (a < b + c) && (b < a + c) && (c < a + b)
  puts 'This triangle doesn\'t exist.'
  exit
end
if a == b && a == c
  puts 'Your triangle isn\'t right, but equilateral and isosceles.'
  return
end
if c**2 == a**2 + b**2
  puts 'Your triangle is right.'
  puts 'In addition it is isosceles.' if a == b
else
  puts 'Your triangle isn\'t right.'
end
