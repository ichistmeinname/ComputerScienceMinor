# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 3.02.2016
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# Warum eigentlich "HashMaps"?
# Meine Recherche ergab, dass es hier `Map` heißt,
#  nur um darauf aufmerksam zu machen, dass es sich
#  um Schlüssel-Wert-Paare handelt. Dabei ist eben
#  zu beachten, dass jeder Schlüssel nur _einmal_
#  vorkommen darf. Insbesondere bedeutet das, dass
#  Werte überschrieben werden, wenn ein Schlüssel ein
#  weiteres Mal verwendet werden.
# Meine Vermutung bzgl. der Implementierung als Baum
#  stimmt für die HashMaps wohl nicht.

# Wie sehen HashMaps nun aus?
hashTest = { :sandra => ["6263","0431-..."],
             :max => ["5555","0151..."]
           };
p(hashTest[:sandra]);
p(hashTest[:max]);

# Verwendung der Methode `.[]=`,
#  um neue Werte hinzuzufügen
hashTest[:insa] = ["3125","0176..."];
p(hashTest);

# Beim Array haben wir nur eine Zuordnung von
#  Indizies zu Werten; HashMaps ermöglichen uns
#  also in diesem Sinne mehr Informationen, da
#  Schlüssel einen genaueren Zugriff erlauben als
#  Indizies. Wenn wir einen Wert im Array vorne
#  hinzufügen, ändern sich alle vorherigen Indizies.
#  Bei der HashMap finden wir über einen Schlüssel
#  immer den Wert, den wir zuletzt für diesen Schlüssel
#  gesetzt haben.
arrayTest = [["true","false"],["Max","Mustermann"]];
red = 0;
green = 1;
p(arrayTest[red]);
p(arrayTest[green]);

# Es folgen sehr viele `for`-Schleifen : )
def arrayToHash_v1(arr_2d,k)
  keys = [];
  for i in 0..arr_2d.size-1 do
    keys = keys + [arr_2d[i][k]];
  end;
  entries = [];
  help = [];
  for i in 0..arr_2d.size-1 do
    for j in 0..arr_2d[i].size-1 do
      if j != k then
        help = help + [arr_2d[i][j]];
      end;
    end;
    entries = entries + [help];
    help = [];
  end;
  hash = {};
  for i in 0..keys.size-1 do
    # hash = hash + {keys[i] => entries[i]}
    hash[keys[i]] = entries[i];
  end;
  return hash;
end;

arr = [["Mustermann","Max"   ,1234],
       ["Exemplaris","Emilie",7890]]

def delete_column(arr,col)
 return arr[0,col] + arr[col+1,arr.size-(col+1)]
end;

# puts("delete_column_test");
# p(delete_column([1,2,3,4,6,7],3));

def arrayToHash(arr_2d,k)
  hash = {}
  for i in 0..arr_2d.size-1 do
    key = arr_2d[i][k];
    entry = delete_column(arr_2d[i],k);
    hash[key] = entry;
  end;
  return hash;
end;

puts("");
# newHash = arrayToHash_v1(arr,2);
newHash = arrayToHash(arr,2);
p(newHash);
p(newHash[1234]);
p(newHash[7890]);


def add_column(arr,col,val)
  return arr[0,col] + [val] + arr[col,arr.size-col]
end;

# p(add_column([1,2,3,6,7,124,135],3,42));

def hashToArray(hash,k)
  arr = [];
  # Hashelemente können nicht über Indizies selektiert werden
  # for i in 0..hash.size-1 do
  #   hash[?]
  # end;
  hash.each do |key,entry|
    arr = arr + [add_column(entry,k,key)]
  end;
  return arr;
end;

newArray = hashToArray(newHash,2);
puts(arr == newArray);
p(hashToArray(newHash,1));

#
## Präsenzaufgabe 2
#

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

# puts(safe_with_respect_to_last_element?([0,2]))

def place_next(qs,size)
  a = []
  for i in 0..size-1 do
    a = a + [qs+[i]]
  end
  return a
end

# p(place_next([0,2],8))

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

def count_solutions(qs,size)
  count = 0;
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      # print_queens(qs)
      # puts("");
      return 1
    else
      qss = place_next(qs,size)
      # `index` wird nicht mehr benötigt
      # index = 0
      # `solvable` wird auch nicht mehr benötigt,
      #  da wir ja alle Lösungen aufsuchen wollen
      # solvable = false
      # while index < qss.size do
      # aus `while` wird `for`
      # Wir zählen _alle_ rekursiven Lösungen
      for i in 0..qss.size-1 do
        count = count + count_solutions(qss[i],size)
        # p(count)
        # index = index + 1
      end
      return count
    end
  else
    return 0
  end
end

def all_solutions(qs,size)
  solutions = [];
  if safe_with_respect_to_last_element?(qs) then
    if complete?(qs,size) then
      return [qs];
    else
      qss = place_next(qs,size)
      for i in 0..qss.size-1 do
        # count = count + count_solutions(qss[i],size)
        solutions = solutions + all_solutions(qss[i],size);
      end
      return solutions
    end
  else
    return [];
  end
end

# puts(solvable?([],8))
# puts(count_solutions([],8));
# solutions = all_solutions([],8)

def solvable2?(queens,size)
  return all_solutions(queens,size).size > 0
end;

def count_solutions2(queens,size)
  return all_solutions(queens,size).size
end;

def print_all_solutions(queens,size)
  solutions = all_solutions(queens,size);
  for i in 0..solutions.size-1 do
    print_queens(solutions[i]);
    puts("");
  end;
end;

# print_all_solutions([],8);
# p(solvable2?([],8));
# p(count_solutions2([],8));

#
## Wiederholungen
#

## Unterschied zwischen \d und \w
##  bei regulären Ausdrücken
reg1 = /\*/
reg2 = /\d*/

str = "12463hAAFDfjsdhf%$&!$"
p(reg1.match(str));
p(reg2.match(str));

## Verwirrung bei Tabellenspaltenbenennung
##  im Zusammenhang mit Datenbanken

# Wir haben die Tabellen
#  `Nachrichten` und `Personen` mit den
#  folgenden Spaltennnamen
################# ############
# Nachrichten   # # Personen #
#---------------# #----------#
# id            # # id       #
# sender_id     # # vorname  #
# empfaenger_id # # nachname #
# text          # #          #
################# ############

# Wenn wir in einer Anfrage auf eine
#  Spalte zugreifen wollen, können wir
#  den Namen einfach direkt nutzen.

# Zum Beispiel können wir alle Nachrichtentexte
#  selektieren, die vom Sender mit der `id` 4
#  geschrieben wurden
# Select text From Nachrichten where sender_id = 4

# Wenn wir nun neben dem Text der Nachricht auch
#  den Namen des Senders als Ergebnis haben wollen,
#  müssen wir mit Hilfe der `sender_id` und Personentabelle
#  den Namen erstmal herausfinden.

# !!! Diese Anfrage enthält einen Fehler !!!
# Select text,name From Nachrichten, Personen where
#  sender_id = 4 And id=sender_id

# Diese Anfrage ist nun nicht korrekt, die Datenbank
#  würde uns darauf hinweisen, dass nicht klar ist,
#  ob wir die Spalte `id` der Tabelle `Personen`
#  oder `Nachrichten` abgreifen wollen (beide Tabellen
#  enthalten diesen Spaltennamen).
# Um diese Uneindeutigkeit zu beheben, müssen wir den
#  vollen Namen der Tabelle angeben und können mittels
#  `.`-Notation auf den Spaltennamen zugreifen.

# Select text,name From Nachrichten, Personen where
#  sender_id = 4 And Personen.id=sender_id

## Objektidentität

# Wir definieren eine Funktion, die auf
#  einem Array arbeitet. Die Funktion gibt
#  das leere Array unverändert zurück und
#  fügt sonst das erste Element zusätzlich
#  ans Ende der Liste an
def funny_fun(arr)
  if arr.size == 0 then
    return arr;
  else
    return arr + [arr[0]]
  end;
end;

# Wir können diese Funktion noch dahingehend
#  überprüfen, ob die Objektidentit des zu
#  übergebenden Arrays gewahrt wird oder nicht.

ex_arr1 = [1,2,3,4,5];
ex_arr2 = [];
new_arr1 = funny_fun(ex_arr1);
new_arr2 = funny_fun(ex_arr2);

# Wie sehen die Originalarrays aus?
puts("## Originalarrays ##");
print("ex_arr1: ");
p(ex_arr1);
print("ex_arr2: ");
p(ex_arr2);

# Wie sehen die neuen Arrays aus?
puts("## Arrays nach Funktionsaufruf ##");
print("new_arr1: ");
p(new_arr1);
print("new_arr2: ");
p(new_arr2);

# Veränderung der Originalarrays
ex_arr1[2] = 4;
ex_arr2[2] = 4;

# Wie sehen die Originalarrays jetzt aus?
puts("## Originalarrays nach Veränderung ##");
print("ex_arr1: ");
p(ex_arr1);
print("ex_arr2: ");
p(ex_arr2);

# Wie sehen die neuen Arrays jetzt aus?
puts("## Neue Arrays nach Veränderung ##");
print("new_arr1: ");
p(new_arr1);
print("new_arr2: ");
p(new_arr2);

# Veränderung der neuen Arrays
new_arr1[0] = 1;
new_arr2[0] = 1;

# Wie sehen die neuen Arrays jetzt aus?
puts("## Neue Arrays nach Veränderung ##");
print("new_arr1: ");
p(new_arr1);
print("new_arr2: ");
p(new_arr2);

# Wie sehen die Originalarrays jetzt aus?
puts("## Originalarrays nach Veränderung ##");
print("ex_arr1: ");
p(ex_arr1);
print("ex_arr2: ");
p(ex_arr2);

# Wir können dabei observieren, dass sich
#  `new_arr2` verändert hat. Dadurch dass wir
#  im Falle eines leeren Arrays, das Array
#  unverändert zurückgeben, wird hier das gleiche
#  Objekt zurückgeben und somit sind mutierende
#  Operationen auf beiden Objekten (new_arr2 und
#  ex_arr2) zu beobachten
