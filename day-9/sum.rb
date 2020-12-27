def read_nums
    nums = []
  
    File.foreach("input.txt") { |line|
      nums << line.to_i
    }
  
    return nums
end

def find_sums
    nums = read_nums
    preamble_length = 25
    found = false

    index = preamble_length
    nums[preamble_length..-1].each  { |num|
        i = index - preamble_length
        j = index - preamble_length
        while !found 
            print "Adding"
            if nums[i] + nums[j] == num 
                puts num
                found = true
            end
            
            if j == index + preamble_length 
                i += 1
                j = i
            end

            if i >= preamble_length 
                break
            end

            j += 1
        end

        if !found 
            return num
        end

        found = false
        index += 1
    }
end

puts find_sums