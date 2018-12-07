struct Shift
  property guard_id : Int32
  property sleep_phases : Array(Tuple(Int32, Int32))

  def initialize(@guard_id, @sleep_phases)
  end

  def total_sleep_length
    sleep_phases.map { |sp| sp[1] - sp[0] }.sum
  end

  def self.load_from_input
    current_id = nil
    sleep_start = nil
    sleep_phases = [] of Tuple(Int32, Int32)
    shifts = [] of Shift

    STDIN.each_line do |line|
      date_end = line.index(']')
      raise "Invalid format" unless date_end

      date_string = line[1...date_end]
      event = line[(date_end + 2)..-1]

      date = Time.parse_local(date_string, "%Y-%m-%d %H:%M")

      case event
      when /^Guard #(\d+) begins shift$/
        if sleep_start
          raise "Previous guard didn't wake up!"
        else
          if current_id
            shifts << Shift.new(current_id, sleep_phases)
            sleep_phases = [] of Tuple(Int32, Int32)
          end

          current_id = $1.to_i
        end
      when "falls asleep"
        if sleep_start
          raise "You need to wake up first!"
        else
          sleep_start = date.minute
        end
      when "wakes up"
        if sleep_start
          sleep_phases << {sleep_start, date.minute}
          sleep_start = nil
        else
          raise "You need to fall asleep first!"
        end
      else
        raise "Unrecognized event: #{event}"
      end
    end

    shifts
  end
end
