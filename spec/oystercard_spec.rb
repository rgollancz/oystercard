require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:angel) { double :station, name: :angel, zone: 1 }
  let(:bank) { double :station, name: :bank, zone: 4 }

  it 'has a empty list of journeys by default' do
    expect(card.journeys).to be_empty
  end

  it 'has a balance of 0 by default' do
    expect(card.balance).to eq 0
  end

  it 'has a balance that can be topped up' do
    expect(card.top_up(Oystercard::MAXIMUM_BALANCE)).to eq card.balance
  end

  it 'raises an error if the maximum balance is exceeded' do
    value = Oystercard::MAXIMUM_BALANCE + 1
    message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + card.balance)-Oystercard::MAXIMUM_BALANCE}"
    expect { card.top_up(value) }.to raise_error message
  end

  context 'with balance and touched in' do
    before :example do
      card.top_up(20)
      card.touch_in(angel)
    end
    it 'records that it has been touched in' do
      expect(card).to be_in_journey
    end
    # it 'records the name of the entry station' do
    #   expect(card.entry_station).to eq angel
    # end
    it 'decreases balance by the minimum fare on touching out' do
      expect {card.touch_out(bank)}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it 'charges penalty fare on double touch in' do
      expect {card.touch_in(bank)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
    end
  end

  context 'with balance and touched in, and out' do
    before :example do
      card.top_up(20)
      card.touch_in(angel)
      card.touch_out(bank)
    end
    it 'has a balance that can be reduced' do
      expect(card.balance).to eq 17
    end
    it 'records the end of a journey' do
      expect(card).not_to be_in_journey
    end
    it 'resets entry station on touching out' do
      expect(card.entry_station).to eq nil
    end
    it 'sets exit station on touching out' do
      expect(card.exit_station).to eq bank
    end
    it 'records previous journeys' do
      expect(card.journeys).to eq [{angel => bank}]
    end
    it 'charges penalty fare on double touch out' do
      expect {card.touch_out(bank)}.to change{card.balance}.by(-Oystercard::PENALTY_FARE)
    end
  end

  it 'raises an error if the balance is too low' do
    expect { card.touch_in(angel) }.to raise_error 'Balance is too low'
  end
end
