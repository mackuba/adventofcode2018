#!/usr/bin/env crystal run

ids = [] of String

STDIN.each_line do |line|
  ids << line.strip
end

len = ids[0].size

0.upto(ids.size - 2) do |i|
  (i + 1).upto(ids.size - 1) do |j|
    diff_pos = nil

    0.upto(len - 1) do |pos|
      if ids[i][pos] != ids[j][pos]
        if diff_pos
          diff_pos = nil
          break
        else
          diff_pos = pos
        end
      end
    end

    if diff_pos
      puts ids[i][0...diff_pos] + ids[i][(diff_pos + 1)..-1]
      exit
    end
  end
end
