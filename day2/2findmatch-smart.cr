#!/usr/bin/env crystal run

ids = [] of String

STDIN.each_line do |line|
  ids << line.strip
end

len = ids[0].size

0.upto(len - 1) do |pos|
  list = ids.map { |id| id[0...pos] + '_' + id[(pos + 1)..-1] }
  list.sort!

  0.upto(ids.size - 2) do |i|
    if list[i] == list[i + 1]
      puts list[i].delete('_')
    end
  end
end
