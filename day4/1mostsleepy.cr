#!/usr/bin/env crystal run

require "./shift"

shifts = Shift.load_from_input

most_sleepy_guard = shifts.group_by(&.guard_id).map { |g, shifts|
  [g, shifts.map(&.total_sleep_length).sum]
}.sort_by(&.[1]).last[0]

minutes = Array.new(size: 60, value: 0)

shifts.select { |sh| sh.guard_id == most_sleepy_guard }.each do |shift|
  shift.sleep_phases.each do |sp|
    sp[0].upto(sp[1] - 1) do |i|
      minutes[i] += 1
    end
  end
end

max_minute = minutes.map_with_index { |m, i| [m, i] }.sort_by(&.[0]).last[1]

puts most_sleepy_guard * max_minute
