require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3
  PENALTY_FARE = 7

  def initialize
    @balance = 0
    @journey_history = [[]]
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    journey = @journey_history.last
    if journey.last == "unset"
       deduct(PENALTY_FARE)
    end
    add_journey
  end


  def touch_out(station)
    deduct(@journey.fare(station))
    @journey_history.pop
    add_journey(station)
  end

  def add_journey(station = "unset")
    @journey = Journey.new(station)
    @journey_history << [@journey.entry_station, station]
  end

  private
  def deduct(value)
    @balance -= value
  end

end
