require 'oystercard'

describe Oystercard do
  it 'has a balance of 0 by default' do
  expect(subject.balance).to eq 0
  end

  it 'balance can be topped up' do
    expect(subject.top_up(40)).to eq subject.balance
  end

  it 'raises an error if the maximum balance is exceeded' do
    value = 100
    message = "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded by £#{(value + subject.balance)-Oystercard::MAXIMUM_BALANCE}"
    expect{subject.top_up(value)}.to raise_error message
  end

  it 'decreases the balance' do
    subject.top_up(40)
    expect(subject.deduct(30)).to eq subject.balance
  end
end
