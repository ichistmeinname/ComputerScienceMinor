# Language: Ruby, Level: Level 4
text = File.read("haeufigkeiten.rb").downcase;

a = Array.new(26,0);

for i in 0..text.length-1 do
  sym = text[i,1].ord-97;
  if sym>=0 && sym<a.size then
    a[sym] = a[sym] + 1;
  end;
end;

for i in 0..a.size-1 do
  if a[i]!=0 then
    print((i+97).chr+":"+a[i].to_s+", ");
  end;
end;

puts();
