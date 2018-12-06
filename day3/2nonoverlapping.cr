#!/usr/bin/env crystal run

struct Rectangle
  property x : Int32, y : Int32
  property width : Int32, height : Int32
  property id : Int32

  def initialize(*, @id, @x, @y, @width, @height)
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

  rectangles << Rectangle.new(id: id[1..-1].to_i, x: x, y: y, width: w, height: h)

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

def has_conflicts(rectangle, on map)
  rectangle.y.upto(rectangle.y + rectangle.height - 1) do |ypos|
    rectangle.x.upto(rectangle.x + rectangle.width - 1) do |xpos|
      if map[ypos][xpos] > 1
        return true
      end
    end
  end

  return false
end

rectangles.each do |r|
  unless has_conflicts(r, on: map)
    puts r.id
    exit
  end
end
