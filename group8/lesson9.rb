# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 4.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

#
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
      min_pos = i;
    end;
  end;
  return min_pos;
end;

# [3,5,4,1,7,9]
# Minimum ab Position 0: 1
# nach swap: [1,5,4,3,7,9]
##### alternativ: [1,3,4,7,9]
# Minimum ab Position 1: 3
# nach swap: [1,3,4,5,7,9]

def min_sort!(a)
  for i in 0 .. a.size-2 do
    #da einelementiges Array immer sortiert
    pos = min_pos_from(a,i);
    swap!(a,i,pos);
  end;
  return a;
end;

test_array = [5,4,1,5,7,9,10,1,4,3,2];
# p(min_sort!(test_array));


def max_pos_until(arr,pos)
  max_pos = 0;
  for i in 0..pos do
    if arr[i] > arr[max_pos] then
      max_pos = i;
    end;
  end;
  return max_pos;
end;

def max_sort!(a)
  # Wir müssen das größte Element
  #  ganz nach rechts schieben!
  for i in 0..a.size-2 do
    right_pos = a.size-1-i;
    max = max_pos_until(a,right_pos);
    swap!(a,max,right_pos);
  end;
  return a;
end;

# Wir sortieren per Hand!

# [5, 1, 3, 6, 4, 2]
# Maximum bis Position 5: 6
# [5,1,3,|2|,4,|6|]
# Maximum bis Position 4: 5
# [|4|,1,3,2,|5|,6]
# Maximum bis Position 3: 4
# [|2|,1,3,|4|,5,6]
# Maximum bis Position 2: 3
# [2,1,|3|,4,5,6]
# Maximum bis Position 1: 2
# [|1|,|2|,3,4,5,6]
# FERTIG!

p(test_array);
p(max_sort!(test_array));
p(max_sort!(test_array));

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

def random_array(size,bound)
  arr = [];
  for i in 0..size-1 do
    arr[i] = rand(bound);
  end
  return arr;
end;

# puts("");
# puts("Generiertes Array:");
# p(random_array(10,11));

# Helper function to print runtime of
#  sorting functions as floating value;
#  the value is printed with overall seven
#  digits and exactly four digts right
#  of the decimal point
def print_float(val)
  printf('%7.4f',val);
end;

# Helper function to print array_size
#  when testing runtime of sorting functions;
#  the value is printed with maximal 6 digits
#  left of the decimal point
def print_array_size(val)
  printf('%6d',val);
end;


def analyse_runtime(size,bound,iteration)

  # print table header
  puts(" Arraygröße | ins_sort! | max_sort! | min_sort! ");
  puts("------------------------------------------------");

  for i in 0..iteration-1
    array_size = (2**i) * size;
    test_array = random_array(array_size,bound);

    min_sort_array = test_array.clone;
    min_sort_start = Time.now;
    min_sort!(min_sort_array);
    min_sort_time = Time.now - min_sort_start;

    max_sort_array = test_array.clone;
    max_sort_start = Time.now;
    max_sort!(max_sort_array);
    max_sort_time = Time.now - max_sort_start;

    ins_sort_array = test_array.clone;
    ins_sort_start = Time.now;
    ins_sort!(ins_sort_array);
    ins_sort_time = Time.now - ins_sort_start;

    tab1 = " " * 3;
    tab2 = " " * 5;
    print(tab1);
    print_array_size(array_size);
    print(tab2);
    print_float(ins_sort_time);
    print(tab2);
    print_float(max_sort_time);
    print(tab2);
    print_float(min_sort_time);
    print("\n");
  end;
end;

analyse_runtime(1000,101,5);
