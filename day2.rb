require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/2/input"), cookie: cookie).split("\n")

hash_1 = {
  "A X" => 4,
  "A Y" => 8,
  "A Z" => 3,
  "B X" => 1,
  "B Y" => 5,
  "B Z" => 9,
  "C X" => 7,
  "C Y" => 2,
  "C Z" => 6,
}

hash_2 = {
  "A X" => 3,
  "A Y" => 4,
  "A Z" => 8,
  "B X" => 1,
  "B Y" => 5,
  "B Z" => 9,
  "C X" => 2,
  "C Y" => 6,
  "C Z" => 7,
}

# PART 1
p data.map { |game| hash_1[game] }.sum

# PART 2
p data.map { |game| hash_2[game] }.sum