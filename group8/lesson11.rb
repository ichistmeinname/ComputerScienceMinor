# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 4.02.2016
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

arr = [1,2,3,4,5];


h = { 1234 => ["Mustermann","Max"], 7890 => ["Exemplaris","Emilie"]};
hash = { "hallo" => { "englisch" => "hello", "franzoesisch" => "bonjour" } };
small_hash = { true => "yes", false => "no"}

# p(h[1234][0,2]);
# p(h[7890]);
# p(hash["hallo"]["englisch"]);
# p(small_hash);

# Neuen Wert hinzufügen mittels `.[]=`
small_hash[true] = [small_hash[true]] + ["ja"];
# p(small_hash);
# Jeder Schlüssel kann nur genau _einmal_ vorkommen und wird
#  bei Wiederverwendung überschrieben

# Statt Werte wie Int, String und Bool können auch _Symbole_ verwendet werden!
symbol_hash = { "hallo" => { :englisch => "hello", :franzoesisch => "bonjour" }}
# p(symbol_hash["hallo"][:englisch])
#
# cond = :stop
# if cond == :stop then
#   puts("Stop!");
# else
#   puts("Weiter!");
# end;
# p(hashToArray(h,1)

# Array in Hash umwandeln

# Arrayselektion
# p([0,1,2,3,4,5][2,3])

# Löscht `col`-ten Eintrag aus `arr`
#  und gibt neues Array (neues Objekt!) zurück
def remove_column(arr,col)
  # clone_arr = arr.clone;
  # clone_arr[col,1] = [];
  # return clone_arr;

  # Alternativ mittels Arrayselektion
  return arr[0,col] + arr[col+1,arr.size-col-1];
end;

# p(remove_column([0,1,2,3,4,5],3));

# `k` gibt die Spalte des inneren Arrays an,
#  dessen Wert als Schlüssel verwendet werden soll
def arrayToHash(arr,k)
  hash = {};
  # for i in 0..arr.size-1 do
  #   # val = arr[i];
  #   # key = val[k];
  #   # entry = remove_column(val,k);
  #   # hash[key] = entry;
  #   hash[arr[i][k]] = remove_column(arr[i],k);
  #   #  hash.[]=  (hash ist tatsächlich ein Hash mit der Struktur { k => val} oder {})
  #   # hash[1234] = remove_column(arr[i],k);
  #   # hash[1234] = ["Mustermann","Max"]
  # end;
  arr.each do |val|
    hash[val[k]] = remove_column(val,k);
  end;
  return hash;
end;

a = [["Mustermann","Max"   ,1234],
     ["Exemplaris","Emilie",7890],
     ["Dylus","Sandra",6263]];
hash = arrayToHash(a,2);
p(hash);
# {1234=>["Mustermann","Max"], 7890=>["Exemplaris","Emilie"]}

def add_column(arr,col,val)
  # Objektidentität nicht gewährleistet!
  # arr[col] = val;
  # return arr;
  return arr[0,col] + [val] + arr[col,arr.size-col];
end;

# p(add_column([0,1,2,3,5,6],4,13));
# [0,1,2,3,13,5,6]

def hashToArray(hash,k)
  arr = [];
  # Wir kommen mit dieser `for`-Schleife leider nicht weiter
  # for i in 0..hash.size-1 do
  #
  # end;
  hash.each do |key,entry|
    # key = 1234
    # entry = ["Mustermann","Max"]
    new_entry = add_column(entry,k,key)
    arr = arr + [new_entry];
  end;
  return arr;
end;

p(hash[0]);
p(hashToArray(hash,1));
# [["Mustermann", 1234, "Max"   ],
#  ["Exemplaris", 7890, "Emilie"]
#  ["Dylus", 6263, "Sandra"]]

#
## Präsenzaufgabe 2
#

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

p(place_next([],8))

def solvable?(qs,size)
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      print_queens(qs)
      return true
    else
      qss = place_next(qs,size)
      # qss = [[0,2],[1],[2]...[7]]
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

# Man will das Anfangsarray nicht von außen sichtbar machen
def count_solutions(size)
  return count_solutions_help([],size);
end;

def count_solutions_help(qs,size)
  count = 0;
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      # print_queens(qs)
      # puts("");
      return 1
    else
      qss = place_next(qs,size)
      # qss = [[0,2],[1],[2]...[7]]
      # index = 0
      # `solvable` wird nicht mehr benötigt,
      #  wir suchen ja alle Lösungen
      # solvable = false
      # while index < qss.size do
      for index in 0..qss.size-1 do
        count = count + count_solutions_help(qss[index],size);
      end;
      return count;
    end
  else
    return count;
  end
end

def all_solutions(size)
  all_solutions_help([],size)
end;

def all_solutions_help(qs,size)
  solutions = [];
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      return [qs];
    else
      qss = place_next(qs,size)
      for index in 0..qss.size-1 do
        solutions = solutions + all_solutions_help(qss[index],size);
      end;
      return solutions;
    end
  else
    return solutions;
  end
end

# puts(solvable?([],21))
# puts(count_solutions(21)); # dauert seeeehr lange

# Wir können alle Wünsche mit `all_solutions`
#  erfüllen
solutions = all_solutions(8);
# Anzahl der Lösungen
# p(solutions.size);

# Ausgabe der Lösungen
# solutions.each do |s|
#   print_queens(s);
#   puts("");
# end;

# Gibt es Lösungen?
# p(all_solutions(size).size > 0);
