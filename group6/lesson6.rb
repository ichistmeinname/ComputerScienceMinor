# Language: Ruby, Level: Level 1

##
## Übungsbetrieb vom 9.12.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##


#
## Präsenzaufgabe 1
#

# Version 1: Ohne Hilfsfunktion
def reverse!(str)
  if str.length <= 1 then
    return str;
  else
    # str = "x!"
    # return "!" + "x" + "a" + "M"
    return reverse(str[1, str.length-1]) + str[0, 1];
  end;
end;
##     str          newStr
# 30    Obj1
# 31
# 32                 Obj1
# 33
#
str = "!";
puts(str);
newStr = reverse!(str);
puts(newStr);
newStr[0,1] = "Doof";
puts(newStr);
puts(str);

# Unsere Erwartungen:
# "!"
# "!"
# "Doof"
# "!"

bla = "Bla";
puts(bla);
bla[bla.length]= "tüdelü"; # bla.[]=(bla.length,0,"tüdelü")
puts(bla);

# Nichtmutierende Variante
# Version 1: Ohne Hilfsfunktion
def reverse(str)                    # Obj1 "Bla"    str
  # str2 = "";
  if str.length <= 1 then
    x = str;                         # Obj1 "Bla"  (str,x)
    # x = x + str2;                    # Obj2 "Bla"  (x)
    # x[x.length,0] = str2;
    # Erzwinge Objekterzeugung durch `+ ""`
    # return str + "";
    # return str.clone;
    str = x;                         # Obj2 "Bla" (x,str)
    return str;
  else
    # str2 = reverse(str[1, str.length-1]) + str[0, 1];
    return reverse(str[1, str.length-1]) + str[0, 1];
  end;
  # return str2;
end;

#  Obj1  #
# String #
# ------ #
# "!"    #
##########
#  Obj2  #
# String #
# ------ #
# "!"    #
##########

#  Obj1a #
# String #
# ------ #
# "Max!" #
##########
#  Obj2a #
# String #
# ------ #
# "!xaM" #
##########

# HangObj            #
# Hangman            #
# -------            #
# @progress: "_____" #
# @word: "Hallo"     #
# @tries:  3         #

str = "!";
puts(str);
newStr = reverse(str);
puts(newStr);
newStr[0,1] = "Doof";
puts(newStr);
puts(str);

##     str          newStr
# 82    Obj1
# 83
# 84                 Obj2
# ..
#
str = "Max!";
puts(str);
puts(reverse(str));
puts(str);

# Max Erwartungen/Hoffnungen:
#  "Max!"
#  "!xaM"
#  "Max!"

# Version 2: Mit Hilfsfunktion
def rev(str, i)
  if i < 0 then
    return "";
  else
    return str[i, 1] + rev(str, i-1);
  end;
end;

def reverse2(str)
  return rev(str, str.length-1);
end;

str = "";
newStr = reverse2(str);
puts(newStr);
newStr[0,1] = "Doof";
puts(newStr);
puts(str);

#
## Präsenzaufgabe 2
#
wuerfel = [
  1, 2, 6, 1, 6, 1, 4, 4, 6, 6,
  6, 1, 6, 5, 1, 1, 3, 3, 2, 4,
  5, 5, 3, 5, 1, 2, 5, 1, 1, 4,
  4, 4, 4, 1, 3, 1, 1, 1, 1, 1
];

def find_longest_plateau(arr)
  startIndex = 0;
  plateauLength = 1;
  currentPLength = 1;
  # an Stelle arr[size] ist der Wert `nil`
  for i in 0 .. arr.size-1 do
    if arr[i] == arr[i+1] then
      currentPLength = currentPLength + 1;
    else
      if plateauLength < currentPLength then
        plateauLength = currentPLength;
        startIndex = i - currentPLength + 1;
      end;
      currentPLength = 1;
    end;
  end;
  return [startIndex, plateauLength];
end;

# Hauptprogramm
plateau = find_longest_plateau(wuerfel);
index = plateau[0];
pLength = plateau[1];
number = wuerfel[index];

print("Das längste Plateau beginnt bei Index " + index.to_s);
print(", ist " + pLength.to_s + " Zeichen lang");
print(" und besteht aus der Zahl " + number.to_s + ".\n");

#
## Präsenzaufgabe 3
#
