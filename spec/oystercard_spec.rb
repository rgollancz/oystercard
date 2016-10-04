require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:angel) {double :station}

  it 'has a balance of 0 by default' do
  expect(card.balance).to eq 0
  end

  it 'has a balance that can be topped up' do
    expect(card.top_up(40)).to eq card.balance
  end

  it 'raises an error if the maximum balance is exceeded' do
    value = 100
    message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + card.balance)-Oystercard::MAXIMUM_BALANCE}"
    expect { card.top_up(value) }.to raise_error message
  end

  it 'has a balance that can be reduced' do
    card.top_up(40)
    expect(card.touch_out).to eq card.balance
  end

  context 'with balance and touched in' do
    before :example do
      card.top_up(20)
      card.touch_in(angel)
    end
    it 'records the start of a journey' do
      expect(card).to be_in_journey
    end
    it 'records the name of the entry station' do
      expect(card.entry_station).to eq angel
    end
    it 'records that the card is within a journey after touching in, before touching out' do
      expect(card).to be_in_journey
    end
    it 'decreases balance by the minimum fare on touching out' do
    expect {card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
    end
    it 'records the end of a journey' do
      card.touch_out
      expect(card).not_to be_in_journey
    end
    it 'resest entry station on touching out' do
      card.touch_out
      expect(card.entry_station).to eq nil
    end
  end

  it 'raises an error if the balance is too low' do
    expect { card.touch_in(angel) }.to raise_error 'Balance is too low'
  end

end
