# Language: Ruby, Level: Level 1
class Account

  def initialize(amount)
    @balance = amount;
  end;

  def get_balance
    return(@balance);
  end;

  def deposit!(amount)
    @balance = @balance + amount;
  end;

  def withdraw!(amount)
    deposit!(-amount);
  end;

  def transfer!(other, amount)
    withdraw!(amount);
    other.deposit!(amount);
  end;
end;

def do_something(k)
  k.withdraw!(42);
end;

k1 = Account.new(100);
do_something(k1);
k2 = Account.new(150);

k1.withdraw!(50);
k2.transfer!(k1,50);

puts(k1.get_balance);
puts(k2.get_balance);
