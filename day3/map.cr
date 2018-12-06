struct Map
  property data : Array(Array(Int32))

  def initialize(width, height)
    @data = (0...height).map { (0...width).map { 0 } }
  end

  def [](x, y)
    @data[y][x]
  end

  def add_rectangle(rect)
    rect.y.upto(rect.y + rect.height - 1) do |ypos|
      rect.x.upto(rect.x + rect.width - 1) do |xpos|
        @data[ypos][xpos] += 1
      end
    end
  end

  def rectangle_has_conflicts(rect)
    rect.y.upto(rect.y + rect.height - 1) do |ypos|
      rect.x.upto(rect.x + rect.width - 1) do |xpos|
        if @data[ypos][xpos] > 1
          return true
        end
      end
    end

    return false
  end
end
