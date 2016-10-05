require_relative 'station'

class Journey
  attr_reader :entry_station, :fare

  def initialize(entry_station = nil)
    @entry_station = entry_station
  end

  def fare(exit_station)
    @exit_station = exit_station
    (@exit_station.zone - @entry_station.zone) + 1
  end


  # if @entry_station != nil
  #   deduct(PENALTY_FARE)
  # end
  # @entry_station = station

end
