def process_bps
  highest = 0
  seats = []

  File.foreach("input.txt") { |line| 
    row = find_row(line[0..6])
    column = find_column(line[7..-1])

    id = find_seat_id(row, column)
    seats << id

    if id > highest 
      highest = id
    end
  }

  seats = seats.sort
  count = nil
  seats.each { |item|
    if count == nil
      count = item
      next
    end

    if count + 1 == item
      count = item
    else
      puts count + 1
      break
    end
  }

  puts highest
end

def find_seat_id(row=0, column=0)
  if row == nil || column == nil 
    raise "error"
  end

  return (row * 8) + column
end

def find_column(order="")
  return binary_search(order.strip, 0, 7)
end

def find_row(order="")
  return binary_search(order.strip, 0, 127)
end

def binary_search(order="", lowerBound=0, upperBound=127)
  if order.length == 1
    if order == "F" || order == "L"
      return lowerBound
    elsif order == "B" || order == "R"
      return upperBound
    end
  end

  determine = order[0]
  order = order[1..-1]

  middle = lowerBound + (upperBound - lowerBound) / 2
  if determine == "F" || determine == "L"
    return binary_search(order, lowerBound, middle)
  elsif determine == "B" || determine == "R"
    m = middle+1
    return binary_search(order, middle+1, upperBound)
  end
end

process_bps