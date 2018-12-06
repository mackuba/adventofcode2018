#!/usr/bin/env crystal run

require "./map"
require "./rectangle"

rectangles = [] of Rectangle
total_width = 0
total_height = 0

STDIN.each_line do |line|
  r = Rectangle.from_line(line)
  rectangles << r

  total_width = Math.max(total_width, r.x + r.width)
  total_height = Math.max(total_height, r.y + r.height)
end

map = Map.new(total_width, total_height)

rectangles.each do |r|
  map.add_rectangle(r)
end

conflicts = 0

0.upto(total_height - 1) do |y|
  0.upto(total_width - 1) do |x|
    conflicts += 1 if map[x, y] > 1
  end
end

puts conflicts
