require_relative 'station'

class Journey
  attr_reader :entry_station, :exit_station


  def initialize(entry_station)
    @entry_station = entry_station
  end

  def fare(exit_station)
    @exit_station = exit_station
    (@exit_station.zone - @entry_station.zone) + 1
  end

end
