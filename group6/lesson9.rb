# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 20.01.2016
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# Beispielausdruck

a = [[1,2,3,4],[5,6,7,8],[9,10,11,12]];
b = [2,3,5,7];
i = 1;

a[i][b[i]] = b[i];
# Was macht dieser Ausdruck für i = 2 überhaupt?
# a[2][b[2]] = b[2];
# a[2][5] = 5;
# `a[2].size` ist allerdings nur 3, daher wird
#  zwischen Position 5 und 3 noch `nil` hinzugefügt
# p(a);
# > [[1,2,3,4],[5,6,7,8],[9,10,11,12,nil,5]]

p(a == [[1,2,3,4],[5,6,7,3],[9,10,11,12]]);
# > true
p(a);
# > [[1,2,3,4],[5,6,7,3],[9,10,11,12]]


# Methodenschreibweise
# a[i][b[i]] = b[i];
# hier verwenden wir <arr>.[]=(<index>,<new_value>)
# a.[](i)[b[i]] = b[i];
# a.[](i)[b[i]] = b.[](i);
# a.[](i)[b.[](i)] = b.[](i);

# Leider falsch (auf der linken Seite einer Zuweisung
#  muss eine Variable stehen); hier findet im Übrigen
#  aber gar keine Zuweisung statt!
# a.[](i).[](b.[](i)) = b.[](i);
# Die Argumentation ist die gleiche wie bei dieser Zuweisung
# 5 = 6 + 7;

a.[](i).[]=(b.[](i),b.[](i));
p(a == [[1,2,3,4],[5,6,7,3],[9,10,11,12]]);
# > true

## Präsenzaufgabe 2
#

# Swaps element at index position `i` in `a` with
#  element at index position `j` in `a`
def swap!(a,i,j)
  dummy = a[i];
  a[i] = a[j];
  a[j] = dummy;
end;

# Finds minimum element of an array `a`,
#  beginning from `pos`
def min_pos_from(a,pos)
  min_pos = pos;
  for i in pos+1 .. a.size-1 do
    if a[i] < a[min_pos] then
      min_pos = i ;
    end;
  end;
  return min_pos;
end;

def min_sort!(a)
  for i in 0 .. a.size-2 do
    #da einelementiges Array immer sortiert
    pos = min_pos_from(a,i);
    swap!(a,i,pos);
  end;
  return a;
end;

# Finds maximum element of an array `a`,
#  beginning from `0` ending with `pos`
def max_pos_from(a,pos)
  max_pos = pos;
  for i in 0..pos-1 do
    if a[i] > a[max_pos] then
      max_pos = i ;
    end;
  end;
  return max_pos;
end;

def max_sort!(a)
  for i in 1 .. a.size-1 do
    # Wir wollen rückwärts laufen!
    j = a.size - i;
    #   a.size - (a.size - 1)
    # = a.size - a.size + 1
    # = 1
    pos = max_pos_from(a,j);
    swap!(a,pos,j);
  end;
  return a;
end;

def random_array(size,bound)
  test_array = [];
  for i in 0..size do
    test_array[i] = rand(bound);
  end;
  return test_array;
end;

# Tests if a given array is already sorted
#  by ascending order
def is_sorted_asc(a)
  sorted = true;
  # for i in 0..a.size-2 do
  # for-Schleife ist eher albern, wir
  #  wollen ja vorzeitig abbrechen, wenn
  #  das Array nicht sortiert ist
  i = 0;
  while !sorted && i < a.size-1 do
    if a[i] > a[i+1] then
      sorted = false;
    end;
    i = i+1;
  end;
  return sorted;
end;

test_array = random_array(1000,101)
p(is_sorted_asc(max_sort!(test_array)));
# > true
p(max_sort!(test_array) == min_sort!(test_array));
# > true


def ins_sort!(a)
  for i in 0..a.size-1 do
    j = i;
    ins = a[i];
    while j>0 && ins < a[j-1] do
      a[j] = a[j-1];
      j=j-1;
    end;
    a[j] = ins;
  end;
  return a;
end;

# Helper function to print runtime of
#  sorting functions as floating value;
#  the value is printed with maximal two
#  digits left and exactly four digts right
#  of the decimal point
def print_float(val)
  printf('%2.4f',val);
end;

# Helper function to print array_size
#  when testing runtime of sorting functions;
#  the value is printed with maximal 6 digits
#  left of the decimal point
def print_array_size(val)
  printf('%6d',val);
end;

# Prints a runtime-table for a given array size,
#  value bound of the random generated array elements
#  and an iteration bound, which sets the number of
#  iteration the array size is doubled.
def test_runtime(array_size,value_bound,iteration_bound)

  # table header
  puts(" Arraygröße | ins_sort! | max_sort! | min_sort! ");
  puts("------------------------------------------------");

  # measure runtime for the three sorting algorithms
  for i in 0..iteration_bound do
    # generate random array
    test_array = random_array((2**i) * array_size,value_bound);

    # measure runtime for `ins_sort!`
    ins_sort_time = Time.now;
    ins_sort!(test_array);
    ins_sort_time = Time.now - ins_sort_time;

    # measure runtime for `max_sort!`
    max_sort_time = Time.now;
    max_sort!(test_array);
    max_sort_time = Time.now - max_sort_time;

    # measure runtime for `min_sort!`
    min_sort_time = Time.now;
    min_sort!(test_array);
    min_sort_time = Time.now - min_sort_time;

    # pretty print table output
    tab1 = " " * 3;
    tab2 = " " * 6;
    print(tab1);
    print_array_size((2**i) * 1000);
    print(tab2);
    print_float(ins_sort_time);
    print(tab2);
    print_float(max_sort_time);
    print(tab2);
    print_float(min_sort_time);
    print("\n");
  end;
end;

# Main function to measure runtime
test_runtime(1000,1000,4);

#
## Präsenzaufgabe 3
#
