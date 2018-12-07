require "./unit"

# polymer = "dabAcCaCBAcCcaDAA"
polymer = STDIN.read_line.strip

start = Unit.chain_from_string(polymer)

# print_table(start)
print_string(start)

start = react_polymer(start)

print_string(start)
