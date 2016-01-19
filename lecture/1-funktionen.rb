# Language: Ruby, Level: Level 2
x = "Hello";

def min(n,m)
  minimum = n;
  if m<minimum then
    minimum = m;
  end;
  return minimum;
end;

def fac(n)
  if n==0 then
    return 1;
  else
    return n*fac(n-1);
  end;
end;

# prints an xmastree of size
# E.g.: for size = 3
#   X
#  XXX
# XXXXX
#   H
def xmastree(size)
  for i in 1..size do
    puts(" "*(size-i)+if i == 2*size/3 then "i" else "X" end*(2*i-1));
  end;
  puts(" "*(size-1)+"H");
end;
# promt prints str to screen and asks user for
# input. The input is returned.
def prompt(str)
  print(str);
  input = gets;
  return input;
end;

puts(fac(3));
puts(fac(5));

s = prompt("Wie gross soll der Baum werden? ").to_i;

xmastree(s);
