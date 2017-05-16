#!/usr/bin/env ruby
puts 'Please enter the sides of a triangle below. Use "space" as a separator.'
data = gets.chomp
sorted = data.split(' ').map(&:to_f).sort
# could also be extracted using "a, b, c = sorted[0..2]"
c = sorted.pop # the longest side
a = sorted.pop
b = sorted.pop
unless (a < b + c) && (b < a + c) && (c < a + b)
  puts 'This triangle doesn\'t exist.'
  return
end
if a == b && a == c
  puts 'Your triangle isn\'t right, but equilateral and isosceles.'
  return
end
if c**2 == a**2 + b**2
  puts 'Your triangle is right.'
else
  puts 'Your triangle isn\'t right.'
end
if a == b || a == c || b == c
  puts 'In addition it is isosceles.'
end
