require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/1/input"), cookie: cookie).split("\n")

i = 1

result = data.map(&:to_i).reduce({}) do |memo, value|
  i += 1 if value.zero?

  memo[i] ||= 0
  memo[i] += value
  memo
end

p result.values.sort.last(3).sum

