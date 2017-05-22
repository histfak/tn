#!/usr/bin/env ruby
array = [0, 1]

loop do
  pointer = array[-1] + array[-2] 
  break if pointer >= 100
  array << pointer
end
