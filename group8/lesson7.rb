# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 17.12.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# `items` has to be an Array
# The elements of `items` have to be Strings
def menue(items)
  n = 0;
  while n<1 || n>items.size do
    for i in 0..items.size-1 do
      puts("(" + (i+1).to_s + ") " + items[i]);
    end
    print("Deine Wahl: ");
    n = gets.to_i;
  end
  return n;
end

# puts(menue(["1-Spieler-Modus","2-Spieler-Modus","Beenden"]));

# `table` has to be an Array of Arrays of Strings
# `mask` has to be an Array of Strings
# `special_pos` has to be an Integer

def pretty_print(mask, table, special_pos)
  for i in 0..table.size-1 do
    for j in 0..mask.size-1 do
      puts(mask[j] + ": " + (if j==special_pos then "\n" else "" end) + table[i][j])
    end
    puts("----------------------------")
  end
end

labels = ["Name","Alter","Geschlecht"];
addressbook = [["Sandra","26","W"],["Sebastian","??","M"],["Tim","105","M"]];
# pretty_print(labels,addressbook,3);

val = "string";

case val
when 1
  puts("Hallo!");
when 2
  puts("Game over!");
when 5
  puts("Soso!");
else
  puts("unexpected value");
end;




#
## Präsenzaufgabe 2
#

# Regulärer Ausdruck für Zeitformat
regexp = /(2[0-3]|[01]?[0-9]):[0-5][0-9]/;

# Welche Ausdruecke matcht `regexp` nicht!
# "13:45"
# "24:00"    Geht nicht so wie gewollt.
# "00:00"
# "9:51"
# "06:30"
# "16 Uhr"   Geht nicht!

testArray = ["13:45,15:00","24:00","00:00","9:51","06:30","16 Uhr"];
test1 = "13:45";

# for i in 0..testArray.size-1 do
#   p(regexp.match(testArray[i]));
# end;

# Für "bessere" Ergebnisse sollte die führende 0 nicht optional sein.

# Datei auslesen und gegen regulären Ausdruck matchen

text = File.read("zeitplan.txt");
# puts(text);
nextMatch = regexp.match(text);
while nextMatch != nil do
  puts(nextMatch);
  remainingString = nextMatch.post_match;
  nextMatch = regexp.match(remainingString);
end;

# Position des Matches herausfinden?

text = "blabla 12:31 blabla";
pos = regexp =~ text;
puts(pos);
puts(text[7]);
