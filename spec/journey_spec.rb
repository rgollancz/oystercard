require 'journey'
require 'oystercard'

describe Journey do
  let(:angel) { double :station, name: :angel, zone: 1 }
  let(:bank) { double :station, name: :bank, zone: 4 }
  let(:card) { Oystercard.new }
  subject(:journey) {described_class.new(angel)}

  it 'should record the entry station' do
    expect(journey.entry_station).to eq angel
  end

  context 'cost is calculated on completion of the journey' do
    before :example do
      card.top_up(20)
      card.touch_in(angel)
      card.touch_out(bank)
    end

    it 'calculates the fare' do
      expect(journey.fare(bank)).to eq 4
    end
  end
end
