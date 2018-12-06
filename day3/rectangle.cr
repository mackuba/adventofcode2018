struct Rectangle
  property x : Int32, y : Int32
  property width : Int32, height : Int32
  property id : Int32

  def initialize(*, @id, @x, @y, @width, @height)
  end

  def self.from_line(line)
    fields = line.split

    id = fields[0]
    raise "incorrect id" unless id.starts_with?('#')

    raise "unexpected field 2" unless fields[1] == "@"

    x, y = fields[2].chomp(':').split(',').map(&.to_i)
    w, h = fields[3].split('x').map(&.to_i)

    Rectangle.new(id: id[1..-1].to_i, x: x, y: y, width: w, height: h)
  end
end
