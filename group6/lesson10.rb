# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 4.11.2015
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# Mit Hilfe von QuickSort sortieren
# arr = [4, 23, 6, 2, 7, -1, 10, 17, 6, 3, 8, 14, 20, 9, 1]
# Pivot: 4 für arr       | l := 0; j-1 := 3;
#                        | j+1 = 5; r := arr.size -1;
# Aufteilung in zwei Teilarrays:
# arr1 = [2,-1,3,1]
# arr2 = [23,6,7,10,17,6,8,14,20,9]

# b = [2,-1,3, 1 ,4,23,6,7,10,17,6,8,14,20,9]
#      l     (j-1)

# Pivot: 2 für arr1
# Aufteilung in zwei Teilarrays:
# arr11 = [-1,1]
# arr12 = [3]
# Pivot: 23 für arr2
# Aufteilung in zwei Teilarrays:
# arr21 = [6,7,10,17,6,8,14,20,9]
# arr22 = []

# Pivot: -1 für arr11
# Aufteilung in zwei Teilarrays:
# arr111 = []
# arr112 = [1]
# Pivot: 3 für arr12
# Aufteilung in zwei Teilarrays:
# arr121

def qsort_h(a,l ,r)
  # Sortiert den Bereich von l bis r
  if l >= r then
    return a.clone;
  else
    b = a.clone; # Legt eine Kopie von a an
    j=l;
    k=r;
    for i in (l+1) .. r do
      if a[i] < a[l] then # Vergleich mit Pivot−Element
        b[j] = a[i];
        j = j+1;
      else
        b[k] = a[i];
        k = k-1;
      end;
    end;
    # Verschiebe Pivot−Element in die Mitte
    b[j] = a[l];
    # Array bis Indexposition `j-1` sortiert
    c = qsort_h(b,l,j-1);
    # arr = [4, 23, 6, 2, 7, -1, 10, 17, 6, 3, 8, 14, 20, 9, 1]
    # Pivot: 4 für arr       | l := 0; j-1 := 3;
    #                        | j+1 = 5; r := arr.size -1;
    # c = [-1,1,2,  3  ,4,23,6,7,10,17,6,8,14,20,9]
    #      l      (j-1)
    return qsort_h(c,j+1,r);
  end;
end ;

def qsort(a)
  return qsort_h(a,0,a.size-1);
end;

arr = [4, 23, 6, 2, 7, -1, 10, 17, 6, 3, 8, 14, 20, 9, 1];
# p(qsort(arr))

#
## Präsenzaufgabe 2
#

# <html>
#   <head>
#      <title> Ein Titel </title>
#   </head>
#   <body>
#     <ol>
#       <li> Eintrag 1 </li>
#       <li> Eintrag 2 </li>
#     </ol>
#   </body>
# </html>

# HTML ::= '<'Tag'>' HTML '</'Tag '>' |
# Tag  ::= 'ul' | 'li' | 'ol' | 'body' | 'head' | 'html'

# HTML ::= '<html>' Head Body  '</html>'
# Head ::= '<head>' Meta '</head>'
# Meta ::= [Title] | {CSS} | {JavaScript} | ...
# Title ::= '<title>' Text '</title>'
# Text ::= {...}
# Body ::= '<body>' {Element} '</body>'
# Element ::= Ol | Ul | I | B | Div | A |
# Ol ::= '<ol>' Li {Li} '</ol>'
# Ul ::= ...
# ...
# Li ::= '<li>' Element '</li>'

# HTML besagt == unsere auferlegten Restriktionen
# HTML besagt: <title> nur innerhalb von <head>
# HTML besagt: <html>-Gerüst ganz außen
# HTML besagt: <li> nur innerhalb von <ul> oder <ol>
# HTML besagt: <tag1> muss irgendwann mit </tag1>
#              geschlossen werden und kein anderer
#              unvollständiger Tag darf dazwischen
#              stehen
