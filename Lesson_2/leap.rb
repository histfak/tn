#!/usr/bin/env ruby
months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 19 => 31, 11 => 30, 12 => 31 }
puts 'Please enter the date below. Use the following format: dd.mm.yyyy'
data = gets.chomp
day, month, year = data.split('.').map(&:to_i)
if year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  months[2] = 29
end
months.delete_if { |key| key >= month }
puts months.values.inject(0, :+) + day
