require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/4/input"), cookie: cookie).split("\n")


# PART 1
count_1 = 0

data.each do |line|
  arr = line.split(",")
  p arr
  subarr_1 = (arr.first.split("-").first.to_i..arr.first.split("-").last.to_i).to_a
  subarr_2 = (arr.last.split("-").first.to_i..arr.last.split("-").last.to_i).to_a
  concat_length = subarr_1.dup.concat(subarr_2.dup).uniq.length
  if concat_length == subarr_1.count || concat_length == subarr_2.count
    count_1 += 1
  end
end

p count_1

# PART 2
count_2 = 0

data.each do |line|
  arr = line.split(",")
  p arr
  subarr_1 = (arr.first.split("-").first.to_i..arr.first.split("-").last.to_i).to_a
  subarr_2 = (arr.last.split("-").first.to_i..arr.last.split("-").last.to_i).to_a
  intersection = subarr_1.intersection(subarr_2)
  count_2 += 1 if !intersection.empty?
end

p count_2