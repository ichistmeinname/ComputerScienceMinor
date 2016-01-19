# Language: Ruby, Level: Level 4
class Fractional

  def initialize(zaehler,nenner)
    teiler = ggT(zaehler,nenner);
    @zaehler = zaehler/teiler;
    @nenner  = nenner/teiler;
  end;

  def get_zaehler
    return @zaehler;
  end;

  def get_nenner
    return @nenner;
  end;

  def to_s
    return (if @nenner==1 then
              @zaehler.to_s
            else if @zaehler>=@nenner then
                   (@zaehler/@nenner).to_s+" "+(@zaehler % @nenner).to_s
                 else
                   @zaehler.to_s
                 end + "/"+@nenner.to_s
            end);
  end;

  private

  def ggT(a,b)
    while a != 0 && b != 0 do
      if a > b then
        a = a % b;
      else
        b = b % a;
      end;
    end;
    return a+b;
  end;

  public

  def +(bruch)
    return Fractional.new(@zaehler * bruch.get_nenner + bruch.get_zaehler * @nenner,
                          @nenner * bruch.get_nenner);
  end;

  def *(other)
    if other.instance_of?(Fixnum) then
      return Fractional.new(@zaehler*other,@nenner);
    else
      return Fractional.new(@zaehler * other.get_zaehler, @nenner * other.get_nenner);
    end;
  end;
end;

x = Fractional.new(2,1);
y = Fractional.new(1,5);


puts((x*2).to_s);
