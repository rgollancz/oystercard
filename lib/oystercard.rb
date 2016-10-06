require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey_history, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    @journey = Journey.new(station)
    @journey.complete == false
  end


  def touch_out(station)
    deduct(@journey.fare(station))
    @journey.complete = true
  end

  end

  # def touch_out(station)
  #   journey = defined? @journey.entry_station
  #   if journey == nil
  #     @journey = Journey.new(:none, :none)
  #     deduct(@journey.penalty_fare(station))
  #   else
  #     deduct(@journey.fare(station))
  #   end
  #   #add_journey
  # end

  # def in_journey?
  #   #  j = defined? @journey.entry_station
  #   #  j != nil
  # end

  def add_journey
    current_journey = {entry_station => exit_station}
    @journey_history << current_journey
  end

  private
  def deduct(value)
    @balance -= value
  end

end
