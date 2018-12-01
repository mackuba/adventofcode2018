#!/usr/bin/env crystal run

sum = 0

STDIN.each_line do |line|
  value = line.strip.to_i
  sum += value
end

puts sum
