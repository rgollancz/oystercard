require 'station'

describe Station do
  subject(:angel){described_class.new(:angel, 1)}

  it 'has a name upon initialization'do
    expect(angel.name).to eq :angel
  end
  it 'has a zone upon initialization'do
    expect(angel.zone).to eq 1

  end
end
