#!/usr/bin/env ruby
array = []
(0..10).each_with_index do |num|
  if num < 2
    array << num
  else
    array << array[-1] + array[-2]
  end
end
