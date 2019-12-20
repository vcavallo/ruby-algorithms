=begin
This is a simple selection selection sort algorithm with a LOT of noise in between.
I've included a QuietSelectionSort, also, to see the code without all the logging noise.

I haven't refactored or anything - this was the first stuff that came out so no
guarantees that it is idiomatic, performant or non-weird. I just wanted to implement
the general algorithm.

I've learned that Ruby is a strange language for things like this.
=end

require 'pry'

class SelectionSort

  def initialize(arr)
    if arr.empty?
      @arr = [5,4,3,2,1]
    else
      @arr = arr
    end
    @passes = 0.0
    @considerations = 0

    @pr = false
    @delay = false
  end

  def sort!
    puts "Initial array:"
    puts ""
    puts "#{ @arr }"
    puts ""
    puts "Starting selection sort..."

    @arr.each_with_index do |item, i|
      puts "" if @pr
      puts "Finding appropriate item to place in index #{ i }..." if @pr

      swap(i, index_of_smallest(i))

      puts "" if @pr
      puts "#{ @arr }"
      puts "(#{ @passes } passes)" if @pr
      sleep 0.1 if @delay
      @passes += 1
    end
  
    puts "Done! Final, sorted array:"
    puts @arr.to_s.ljust(25)
    puts "(In #{ @passes } passes)"
    puts "(Considered #{ @considerations } items)"
    puts "(Array was #{ @arr.length } long)"
  end

  def index_of_smallest(start)
    index_of_minimum = start

    puts "Will look in #{ @arr.slice(index_of_minimum, @arr.length) }:" if @pr

    (start...@arr.size).each do |i|
      print "Is #{ @arr[i] } smaller than #{ @arr[index_of_minimum] }? " if @pr

      if @arr[i] < @arr[index_of_minimum]
        index_of_minimum = i

        print "Yup. " if @pr
        puts "New smallest is #{ @arr[i] }" if @pr

      else
        print "No, skip it." if @pr
        puts "" if @pr
      end
      sleep 0.5 if @delay
      @considerations += 1
    end
    @passes += (start.to_f) / ((@arr.length) - start).to_f

    puts "Got the next smallest item: #{ @arr[index_of_minimum] }!" if @pr
    puts "Swapping it now. new array:" if @pr

    return index_of_minimum
  end

  def swap(i, j)
    temp = @arr[i]
    @arr[i] = @arr[j]
    @arr[j] = temp
  end

end

class QuietSelectionSort

  def initialize(arr)
    if arr.empty?
      @arr = [5,4,3,2,1]
    else
      @arr = arr
    end
  end

  def sort!
    puts "Initial array:"
    puts ""
    puts "#{ @arr }"

    @arr.each_with_index do |item, i|
      swap(i, index_of_smallest(i))
      puts "#{ @arr }"
    end

    puts "Sorted:"
    puts ""
    puts "#{ @arr }"
  end

  def index_of_smallest(start)
    index_of_minimum = start

    (start...@arr.size).each do |i|
      if @arr[i] < @arr[index_of_minimum]
        index_of_minimum = i
      end
    end
    return index_of_minimum
  end

  def swap(i, j)
    temp = @arr[i]
    @arr[i] = @arr[j]
    @arr[j] = temp
  end

end

*array = ARGV
array.map!(&:to_i)

s = SelectionSort.new(array)
s.sort!

#s = QuietSelectionSort.new(array)
#s.sort!
