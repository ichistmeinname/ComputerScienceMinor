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
def reverse(xyz)
  # x = xyz;
  # xyz[0,1] = "bla";
  if xyz.length <= 1 then
    # return xyz + "";
    # return xyz * 1;
    return xyz.clone;
  else
    # xyz = "753"
    # return reverse("53").+("7")
    # return           (("3"  + "5")  + "7")
    # return   "357"
    return reverse(xyz[1, xyz.length-1]) + xyz[0, 1]; # "hallo".+(" welt")
  end;
end;

str = "7";
puts(str);
revStr = reverse(str);
puts(revStr);
revStr[0,1] = "bla";
puts(revStr);
puts(str);

# Version 2: Mit Hilfsfunktion
def rev(str, i)
  # str = "75", i = -1
  if i < 0 then
    return "";
  else
    # return  "5"  + "7" + ""
    return str[i, 1] + rev(str, i-1);
  end;
end;

def reverse2(str)
  return rev(str, str.length-1);
end;

str = "75";
puts(str);
revStr = reverse2(str);
puts(revStr);
revStr[0,1] = "bla";
puts(revStr);
puts(str);

#               str         x
# Aufruf        Obj1
# 16                        Obj1
# 17
# 22
#
#

########## ########## ##########
#  Obj1  # #  Obj2  # #  Obj3  #
# String # # String # # String #
# ------ # # ------ # # ------ #
# "753"  # #  "35"  # # "357"  #
########## ########## ##########

######################
#  HangObj           #
# Hangman            #
# ------------------ #
# @progress = "d___" #
# @word = "doof"     #
# @tries = 3         #
######################


#
## Präsenzaufgabe 2
#

def find_longest_plateau(arr)
  startIndex = 0;
  plateauLength = 1;
  cPlateauLength = 1;
  for i in 0 .. arr.size-1 do
    # Indexzugriff außerhalb des Ranges resultiert in `nil`
    # Wenn im Array `nil` als Element vorkommt, kann das
    #  zu falschen Ergebnissen führen
    # Eine Abfrage bzgl. Arrayende wäre sinnvoll
    if arr[i] == arr[i+1] then
      cPlateauLength = cPlateauLength + 1;
    else
      if cPlateauLength > plateauLength then
         startIndex = i - cPlateauLength + 1;
         plateauLength = cPlateauLength;
      end;
      cPlateauLength = 1;
    end;
  end;
  return [startIndex,plateauLength];
end;

# Hauptprogramm
wuerfel = [
  1, 2, 6, 1, 6, 1, 4, 4, 6, 6,
  6, 1, 6, 5, 1, 1, 3, 3, 2, 4,
  5, 5, 3, 5, 1, 2, 5, 1, 1, 4,
  4, 4, 4, 1, 3, 1, 1, 1, 1, 1
];


puts(wuerfel[39]);
puts(wuerfel[40] == "");
puts(wuerfel[40] == []);
puts(wuerfel[4261] == nil);
puts(nil == nil);

plateau = find_longest_plateau(wuerfel);
index = plateau[0];
pLength = plateau[1];
number = wuerfel[index];
print("Das längste Plateau startet bei Index " + index.to_s);
print(", ist " + pLength.to_s + " Zeichen lang");
print(" und besteht aus der Zahl " + number.to_s + ".\n");


#
## Präsenzaufgabe 3
#

def remove_at(str,i)
  # str = "monkey", i = 3
  #        "mon"  + "ey"
  return str[0,i] + str[i+1,str.length-i-1];
end;

# Mutierende Prozedur (kein Rückgabewert)
def remove_at!(str,i)
  str[i,1] = "";
end;

# Hauptprogramm

var = "monkey";
index = gets().chop.to_i;
newVar = remove_at(var,index);
puts(newVar);
puts(var);

var = "monkey";
remove_at!(var,3);
puts(var);
