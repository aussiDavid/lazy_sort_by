RSpec.describe Enumerable do
  it { expect([]).to respond_to :lazy_sort_by }

  describe '#lazy_sort_by' do
    it { expect([].lazy_sort_by).to eq([]) }
    it { expect([1].lazy_sort_by).to eq([1]) }
    it { expect([1, 2].lazy_sort_by).to eq([1, 2]) }
    it { expect([2, 1].lazy_sort_by).to eq([1, 2]) }
    it { expect([{ a: 2 }, { a: 1 }].lazy_sort_by { |x| x[:a] }).to eq([{ a: 1 }, { a: 2 }]) }
    it { expect([{ a: 2 }, { a: 1 }].lazy_sort_by { |x| [x[:a]] }).to eq([{ a: 1 }, { a: 2 }]) }
  end
end
