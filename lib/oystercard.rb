class Oystercard
  attr_reader :balance, :in_use

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  def initialize
    @balance = 0
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_use
  end

  private
  def deduct(value)
    @balance -= value
  end
end
