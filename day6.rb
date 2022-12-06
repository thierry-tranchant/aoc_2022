require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/6/input"), cookie: cookie).split("\n").first.chars

def find_signal(data, chain_length)
  result = 0

  data.each_index do |index|
    if data[index..index + chain_length - 1] == data[index..index + chain_length -1].uniq
      result = index + chain_length
      break
    end
  end

  result
end

# PART 1
p find_signal(data, 4)

# PART 2
p find_signal(data, 14)
