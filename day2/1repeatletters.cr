#!/usr/bin/env crystal run

twos = 0
threes = 0

STDIN.each_line do |line|
  string = line.strip
  chars_in_string = Hash(Char, Int32).new(0)

  string.chars.each do |ch|
    chars_in_string[ch] += 1
  end

  twos += 1 if chars_in_string.values.includes?(2)
  threes += 1 if chars_in_string.values.includes?(3)
end

puts twos * threes
