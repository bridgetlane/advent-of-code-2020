def read_nums
    nums = []
  
    File.foreach("input.txt") { |line|
      nums << line.to_i
    }
  
    return nums
end

def find_sums(nums=[])
    preamble_length = 25
    found = false

    index = preamble_length
    nums[preamble_length..-1].each { |num|
        i = index - preamble_length
        j = index - preamble_length
        while !found
            if nums[i] + nums[j] == num 
                found = true
            end
            
            if j == index + preamble_length 
                i += 1
                j = i
            end

            if i >= index + preamble_length 
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

def find_range(want=0, nums=[])
    nums.each_with_index { |num, index|
        total = 0
        i = index
        subset = []
        while total != want && i < nums.length
            #printf "%d, %d\n", index, i
            if nums[i] >= want 
                i = nums.length
                next
            end

            total = total + nums[i]
            #puts total
            subset << nums[i]
            if total == want
                #puts subset
                return subset
            end

            i += 1
        end

        if total == want 
            return subset
        end
    }

    return []
end

def find_weakness(subset=0)
    subset = subset.sort
    return subset[0] + subset[-1]
end

nums = read_nums
puts find_weakness(find_range(find_sums(nums), nums))