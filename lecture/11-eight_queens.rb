# Language: Ruby, Level: Level 4
def print_queens(qs)
  qs.each do |q|
    puts("* "*q+"Q "+"* " * (qs.size-q-1))
  end
end

#print_queens([1,3,0,2])

def complete?(qs,size)
  return qs.size==size
end

#puts(complete?([1,3,0,2],4))

def safe_with_respect_to_last_element?(qs)
  safe = true
  for i in 0..qs.size-2 do
    q_i = qs[i]
    j = qs.size-1
    q_j = qs[j]
    vertical = q_i == q_j
    diagonal = (q_i-q_j).abs == j - i
    if vertical || diagonal then
      safe = false
    end
  end
  return safe
end

puts(safe_with_respect_to_last_element?([0,2]))

def place_next(qs,size)
  a = []
  for i in 0..size-1 do
    a = a + [qs+[i]]
  end
  return a
end

p(place_next([0,2],8))

def solvable?(qs,size)
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      print_queens(qs)
      return true
    else
      qss = place_next(qs,size)
      index = 0
      solvable = false
      while !solvable && index < qss.size do
        solvable = solvable?(qss[index],size)
        index = index + 1
      end
      return solvable
    end
  else
    return false
  end
end

puts(solvable?([],21))
