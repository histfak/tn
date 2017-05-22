#!/usr/bin/env ruby
vowels = %w[a e i o u]
hash = {}
('a'..'z').each_with_index do |char, index|
  if vowels.include?(char)
    hash[char] = index + 1
  end
end
