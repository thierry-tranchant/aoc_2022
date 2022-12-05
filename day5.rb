require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/5/input"), cookie: cookie).split("\n")

raw_table = data.select { |str| str.include?("[") }.map { |str| str.gsub("    ", " [] ").split }
parsed_table = raw_table.transpose.map(&:reverse).map { |arr| arr.reject { |el| el == "[]" } }

moves_arr = data.select { |str| str.include?("move") }.map { |str| str.scan(/\d+/) }.map { |arr| arr.map(&:to_i) }

def reorder(parsed_table, moves_arr, reverse: false)
  moves_arr.each do |moves|
    to_push = parsed_table[moves[1] - 1][-moves[0]..]
    to_push = to_push.reverse if reverse
    parsed_table[moves[2] - 1] += to_push
    parsed_table[moves[1] - 1] = parsed_table[moves[1] - 1][..-(moves[0] + 1)]
  end

  parsed_table.map { |arr| arr.last }.flatten.map { |el| el.gsub(/[\[\]]/, "") }.join
end

# PART 1
p reorder(parsed_table.dup, moves_arr, reverse: true)

# PART 2
p reorder(parsed_table.dup, moves_arr)
