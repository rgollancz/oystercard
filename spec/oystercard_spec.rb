require 'oystercard'

describe Oystercard do

  it 'has a balance of 0 by default' do
  expect(subject.balance).to eq 0
  end

  it 'has a balance that can be topped up' do
    expect(subject.top_up(40)).to eq subject.balance
  end

  it 'raises an error if the maximum balance is exceeded' do
    value = 100
    message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + subject.balance)-Oystercard::MAXIMUM_BALANCE}"
    expect { subject.top_up(value) }.to raise_error message
  end

  it 'has a balance that can be reduced' do
    subject.top_up(40)
    expect(subject.touch_out).to eq subject.balance
  end

  context 'with balance' do
    before :example do
      subject.top_up(20)
    end
    it 'records the start of a journey' do
      expect(subject.touch_in).to be true
    end
    it 'records that the card is within a journey after touching in, before touching out' do
      expect(subject.touch_in).to eq subject.in_journey?
    end

    it 'decreases balance by the minimum fare on touching out' do
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end
  end

  it 'records the end of a journey' do
    subject.touch_out
    expect(subject.in_journey?).to be false
  end

  it 'raises an error if the balance is too low' do
    expect { subject.touch_in }.to raise_error 'Balance is too low'
  end

end
