#!/usr/bin/env crystal run

require "./shift"

shifts = Shift.load_from_input

summary = shifts.group_by(&.guard_id).map do |guard_id, shifts|
  minutes = Array.new(size: 60, value: 0)

  shifts.each do |shift|
    shift.sleep_phases.each do |sp|
      sp[0].upto(sp[1] - 1) do |i|
        minutes[i] += 1
      end
    end
  end

  max_minute_times, max_minute = minutes.map_with_index { |m, i| [m, i] }.sort_by(&.[0]).last

  [guard_id, max_minute_times, max_minute]
end

guard_id, max_minute_times, max_minute = summary.sort_by(&.[1]).last

puts guard_id * max_minute
