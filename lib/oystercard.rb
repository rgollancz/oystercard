require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3
  PENALTY_FARE = 7

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(value)
    total_value = value + @balance
    raise "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(total_value) - MAXIMUM_BALANCE}" if total_value > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    raise 'Balance is too low' if @balance < MINIMUM_BALANCE
    if @entry_station != nil
      deduct(PENALTY_FARE)
    end
    @entry_station = station
  end

  def touch_out(station)
    if @entry_station == nil
      deduct(PENALTY_FARE)
    else
      deduct(MINIMUM_FARE)
    end
    @exit_station = station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private
  def deduct(value)
    @balance -= value
  end

  def add_journey
    current_journey = {@entry_station => @exit_station}
    @journeys << current_journey
  end
end
