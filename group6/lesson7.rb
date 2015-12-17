# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 16.12.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##
##   Wegen der case-Ausdruecke ist Level 4 notwendig.
##

#
## Präsenzaufgabe 1
#

# Wie funktionieren case-Ausdruecke?
test = 5;

case test
when 1
  puts("1")
when 2
  puts("2")
  puts("doof!")
  puts("immernoch doof")
when 4
when 3
else
  puts("unexpected")
end;

# Siehe Chat-Ordner für die Erweiterung des Chats

#
## Präsenzaufgabe 2
#

# <komplexerAusdruck>?  -- optionaler komplexer Ausdruck
#
regexp = /(2[0-3]|[01]?[0-9]):([0-5]([0-9]))/;

# 1) "13:45"
# 2) "24:00"  Geht nicht!
# 3) "00:00"
# 4) "9:51"
# 5) "06:30"
# 6) "16 Uhr" Geht nicht!
testArray = ["13:45","24:00","00:00","9:51","6:30","16 Uhr"];

for i in 0 .. testArray.size-1 do
  match = regexp.match(testArray[i]);
  puts(testArray[i]);
  print("Ergebnis: ");
  p(match);
end;

# Mit ".." kann in der Ordnerstruktur abgestiegen werden
#  und durch Angabe eines Ordners, kann auch in der Ordnerstruktur
#  aufgestiegen werden.
txt = File.read("group6/../zeitplan.txt")

nextMatch = regexp.match(txt);
while nextMatch != nil do
  p(nextMatch);
  puts(nextMatch.to_s);
  txtRemainder = nextMatch.post_match;
  nextMatch = regexp.match(txtRemainder);
end;
