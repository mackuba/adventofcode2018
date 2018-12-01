#!/usr/bin/env crystal run

list = [] of Int32

STDIN.each_line do |line|
  value = line.strip.to_i
  list << value
end

found = {0 => true}
sum = 0

loop do
  list.each do |value|
    sum += value
    if found[sum]?
      puts sum
      exit
    else
      found[sum] = true
    end
  end
end
