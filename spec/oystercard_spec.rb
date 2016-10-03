require 'oystercard'

describe Oystercard do
  it 'has a balance of 0 by default' do
  expect(subject.balance).to eq 0
  end

  it 'balance can be topped up' do
    expect(subject.top_up(40)).to eq subject.balance
  end
end
