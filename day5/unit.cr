class Unit
  property code : Char
  property previous : Unit?
  property next : Unit?

  def initialize(@code)
  end

  def reacts_with?(other)
    other.code.upcase == code.upcase && other.code != code
  end

  def self.chain_from_string(string)
    last = nil
    start = nil

    string.chars.each do |ch|
      unit = Unit.new(ch)
      unit.previous = last

      if last
        last.next = unit
      else
        start = unit
      end

      last = unit
    end

    start
  end
end

def print_table(first)
  unit = first
  while unit
    a = [] of Char
    a << unit.code
    if prev = unit.previous
      a << prev.code
    else
      a << ' '
    end
    if nxt = unit.next
      a << nxt.code
    else
      a << ' '
    end
    p a
    unit = unit.next
  end
end

def print_string(first)
  unit = first
  length = 0

  while unit
    print(unit.code)
    unit = unit.next
    length += 1
  end

  puts " (#{length})"
end

def length_of_chain(first)
  unit = first
  length = 0

  while unit
    length += 1
    unit = unit.next
  end

  length
end

def react_polymer(first)
  left = first

  while right = (left && left.next)
    if left.reacts_with?(right)
      before_left = left.previous
      after_right = right.next

      # puts "Boom: [#{left.code}][#{right.code}]"

      if before_left
        before_left.next = after_right
        left = before_left
        after_right.previous = before_left if after_right
      else
        left = first = after_right
        after_right.previous = nil if after_right
      end

      # print_table(first)
      # print_string(first)
    else
      left = right
    end
  end

  first
end
