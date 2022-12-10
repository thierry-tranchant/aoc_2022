require "net/http"

cookie = "session=my_cookie"
data = Net::HTTP.get(URI("https://adventofcode.com/2022/day/7/input"), cookie: cookie).split("\n")

class Directory
  attr_accessor :name, :parent_directory, :children_directories, :regular_files

  def initialize(name, parent_directory = nil)
    @name = name
    @parent_directory = parent_directory
    @children_directories = []
    @regular_files = []
  end

  def files_size
    regular_files.sum { |regular_file| regular_file.size }
  end

  def size
    files_size + @children_directories.sum { |directory| directory.size }
  end
end

class RegularFile
  attr_reader :size

  def initialize(name, size)
    @name = name
    @size = size
  end
end

class Visitor
  attr_reader :root

  def initialize(data)
    @data = data
  end

  def call
    @root = Directory.new("/")
    @directories = [@root]

    @data.each do |str|
      if str.start_with?("$")
        handle_command(str) 
      elsif str.start_with?("dir")
        create_directory(str)
      else
        create_regular_file(str)
      end
    end

    @directories
  end
  
  def handle_command(str)
    change_directory(str) if str.split[1] == "cd"
  end

  def change_directory(str)
    @working_directory = find_directory(str)
  end

  def create_directory(str)
    directory = Directory.new(str.split.last, @working_directory)
    @working_directory.children_directories << directory
    @directories << directory
    directory
  end

  def create_regular_file(str)
    regular_file = RegularFile.new(str.split.last, str.split.first.to_i)
    @working_directory.regular_files << regular_file
    regular_file
  end

  def find_directory(str)
    return go_to_parent_directory if str.split.last == ".."

    directory = @directories.find { |dir| dir.name == str.split.last && dir.parent_directory == @working_directory }
    directory ? directory : create_directory(str)
  end

  def go_to_parent_directory
    @working_directory.parent_directory
  end
end

visitor = Visitor.new(data)
directories = visitor.call

# PART 1
p directories.select { |directory| directory.size <= 100_000 }.sum { |directory| directory.size }

# PART 2
total_space = 70_000_000
free_space_to_have = 30_000_000

free_space = total_space - visitor.root.size
space_to_free = free_space_to_have - free_space

eligible_directories = 
  directories.select { |directory|
    directory.size >= space_to_free
  }.sort { |dir_a, dir_b|
    dir_a.size <=> dir_b.size
  }

p eligible_directories.map(&:size).first

