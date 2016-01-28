# Language: Ruby, Level: Level 4

##
## Übungsbetrieb vom 28.01.2016
##
##   alle mit `#` beginnenden Zeilen sind Kommentare
##

#
## Präsenzaufgabe 1
#

# Per Hand mit Hilfe von QuickSort sortieren
arr = [4, 23, 6, 2, 7, -1, 10, 17, 6, 3, 8, 14, 20, 9, 1]
# Pivotelement: 4
# Aufteilung in zwei Teilarrays
# (alle Einträge in arr1 sind kleiner als 4
#  alle Einträge in arr2 sind größer oder gleich 4)
# arr1 = [2,-1,3,1]
# arr2 = [23,6,7,10,17,6,8,14,20,9]

#        [4, 23, 6, 2, 7, -1, 10, 17, 6, 3, 8, 14, 20, 9, 1]
#         |
#          ----- Pivotelement 4
#               |
#  [2,-1,3,1]  [4]            [23,6,7,10,17,6,8,14,20,9]
#   |                          |
#    ------ Pivotelement 2      ------------------- Pivotelement 23
#          |                                       |
#  [-1,1] [2] [3]        [6,7,10,17,6,8,14,20,9]  [23] []
#   |                     |
#    -- Pivotelement -1    --- Pivotelement 6
#      |                      |
#  [] [-1] [1]           []  [6] [7,10,17,6,8,14,20,9]]
#                                 |
#                                  --- Pivotelement 7
#                                     |
#                                [6] [7] [10,17,8,14,20,9]
#

## Präsenzaufgabe 2
#

# <html>
#   <head>
#      <title> Ein Titel </title>
#   </head>
#   <body>
#     <ul>
#       <li> Eintrag 1 </li>
#       <li> Eintrag 2 </li>
#     </ul>
#     <ol>
#        <li> Eintrag 1a </li>
#        <li> Eintrag 2a </li>
#     </ol>
#   </body>
# </html>
#
# HTML ::= '<html>' Head Body '</html>'
# Head ::= '<head>' Meta '</head>'
# Meta ::= '<title>' Text '</title>' | CSS | JavaScript | ... |
# Body ::= '<'body'>' Content{Content} '</' body '>'
# Content ::= Ul | Ol | I | B | Div | A | ...
# Ul ::= '<ul>' ({LI} | Content {Content} | Text) '</ul>' |
# Ol ::= '<ol>' ( {Li} | Content {Content} | Text) '</ol>'
# LI ::= '<li>' (Content {Content} | Text) '</li>'

# Text ::= AlphaNum | SpecialChar

# Was ich nicht haben möchte: <li><ul> </li></ul>
# Was ich lieber haben möchte: <li><ul></ul></li>
# Was ich haben möchte: <li> soll nur innerhalb <ul> oder <ol> auftreten

#              Content
#                  |
#          <ul> Content </ul>
#                  |
#           <li> Content </li>
#                   |
#                 Text

#                      HTML
#                /      |       \
#             <head>   HTML  <head>
#                  /    |     \
#             <title>  HTML  </title>
#                       |
#                   'Ein Titel'
#

#
## Präsenzaufgabe 3
#

k = 1 + 4;
j = 1.+(4);
puts(j == k);

a = [[1,2,3],[3,2,1],[2,3,1]];
b = [1,2,5,4,5,6,7,8,9]
i = 2;

# a[i][b[i]] = b[i]
# [2,3,1][b[i]]
# [2,3,1][b[2]]
# [2,3,1][5]
# [2,3,1,nil,nil,3]

# 3 = 1+5;
# auf der linken Seite von "=" dürfen nur Variablen stehen!

# a[i][b[i]] = b[i]
#a.[](i)[b[i]] = b[i]
# a.[](i)[b.[](i)] = b.[](i)
# a.[](i).[](b.[](i)) = b.[](i)
# geht so nicht, für i=2 steht dort
# [2,3,1] = 5
# arr[i] = j ist in Methodenschreibweise
# arr.[]=(i,j)
a.[](i).[]=(b.[](i), b.[](i))



# [[1,2,3],[3,2,1],[2,3,1,nil,nil,5]]
p(a);
