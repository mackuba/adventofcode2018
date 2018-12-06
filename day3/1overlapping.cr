#!/usr/bin/env crystal run

struct Rectangle
  property x : Int32, y : Int32
  property width : Int32, height : Int32

  def initialize(@x, @y, @width, @height)
  end
end

rectangles = [] of Rectangle
total_width = 0
total_height = 0

STDIN.each_line do |line|
  fields = line.split

  id = fields[0]
  raise "incorrect id" unless id.starts_with?('#')

  raise "unexpected field 2" unless fields[1] == "@"

  x, y = fields[2].chomp(':').split(',').map(&.to_i)
  w, h = fields[3].split('x').map(&.to_i)

  rectangles << Rectangle.new(x, y, w, h)

  total_width = Math.max(total_width, x + w)
  total_height = Math.max(total_height, y + h)
end

map = (0...total_height).map { (0...total_width).map { 0 } }

rectangles.each do |r|
  r.y.upto(r.y + r.height - 1) do |ypos|
    r.x.upto(r.x + r.width - 1) do |xpos|
      map[ypos][xpos] += 1
    end
  end
end

conflicts = 0

0.upto(total_height - 1) do |y|
  0.upto(total_width - 1) do |x|
    conflicts += 1 if map[y][x] > 1
  end
end

puts conflicts
