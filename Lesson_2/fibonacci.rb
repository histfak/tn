#!/usr/bin/env ruby
def fib(num) # more effective non-recursive way
  seq = []
  (0..num).each do |num|
    if num < 2
      seq << num
    else
      seq << seq[-1] + seq[-2]
    end
  end
  seq.last
end

a = []
i = 0
while i <= 100
  a << fib(i)
  i += 1
end
