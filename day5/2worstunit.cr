require "./unit"

polymer = STDIN.read_line.strip

start = Unit.chain_from_string(polymer)
length = length_of_chain(start)
reacted = react_polymer(start)
reacted_length = length_of_chain(reacted)
puts "Original: #{length} -> #{reacted_length}"

best_result = length
letter = nil

polymer.chars.map(&.upcase).sort.uniq.each do |ch|
  filtered = polymer.delete("#{ch}#{ch.downcase}")
  start = Unit.chain_from_string(filtered)
  length = length_of_chain(start)
  reacted = react_polymer(start)
  reacted_length = length_of_chain(reacted)
  puts "#{ch}: #{length} -> #{reacted_length}"

  if reacted_length < best_result
    best_result = reacted_length
    letter = ch
  end
end

puts "Unit to remove: #{letter} (#{best_result})"
