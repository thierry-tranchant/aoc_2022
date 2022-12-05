require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/3/input"), cookie: cookie).split("\n")

hash = {}
i = 1

("a".."z").to_a.each do |letter|
  hash[letter] = i
  i += 1
end

("A".."Z").to_a.each do |letter|
  hash[letter] = i
  i += 1
end

# PART 1
count_1 = 0

data.each do |str|
  arr_1 = str[..str.length.div(2)-1].chars
  arr_2 = str[str.length.div(2)..].chars
  arr_1.intersection(arr_2).each { |letter| count_1 += hash[letter] }
end

p count_1

# PART 2
count_2 = 0

data.each_slice(3) do |subarr|
  arr_1 = subarr.first.chars
  arr_2 = subarr[1].chars
  arr_3 = subarr.last.chars
  arr_1.intersection(arr_2).intersection(arr_3).each { |letter| count_2 += hash[letter] }
end

p count_2