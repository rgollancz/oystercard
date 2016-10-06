require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station

    PENALTY_FARE = 7

  def initialize(entry_station)
    @entry_station = entry_station
  end

  def fare(exit_station)
    @exit_station = exit_station
    (@exit_station.zone - @entry_station.zone) + 1
  end

  def penalty_fare(exit_station)
    @exit_station = exit_station
    PENALTY_FARE
  end

  # if @entry_station != nil
  #   deduct(PENALTY_FARE)
  # end
  # @entry_station = station

end
