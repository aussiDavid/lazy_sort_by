RSpec.describe Enumerable do
  it { expect([]).to respond_to :lazy_sort_by }

  describe '#lazy_sort_by' do
    context 'when sorting 1 item' do
      subject(:lazy_sort_by) { [one].lazy_sort_by { [ ->(x) { x.length }, ->(x) { x.size } ] } }
        
      let(:one) { double :one, length: 1, size: 1 }
    
      it { is_expected.to eq [one] }
    end
    
    context 'when sorting 2 items' do
      subject(:lazy_sort_by) { [two, one].lazy_sort_by { [ ->(x) { x.length }, ->(x) { x.size } ] } }
        
      let(:one) { double :one, length: 1, size: 2 }
      let(:two) { double :two, length: 3, size: 4 }
    
      it { is_expected.to eq [one, two] }
    end
    
    context 'when sorting 2 items with an expensive second term' do
      subject(:lazy_sort_by) do
        [two, one].lazy_sort_by do
          [
            ->(x) { x.length },
            ->(x) { sleep(3); x.size }
          ]
        end
      end
        
      let(:one) { double :one, length: 1, size: 2 }
      let(:two) { double :two, length: 3, size: 4 }
    
      it { expect { lazy_sort_by }.to perform_under(3).sec }
      it { is_expected.to eq [one, two] }
    end
    
    context 'when sorting 2 items with the same first terms' do
      subject(:lazy_sort_by) { [two, one].lazy_sort_by { [ ->(x) { x.length }, ->(x) { x.size } ] } }
        
      let(:one) { double :one, length: 1, size: 2 }
      let(:two) { double :two, length: 1, size: 3 }
    
      it { is_expected.to eq [one, two] }
    end
    
    context 'when sorting 2 items with the same first of 3 terms' do
      subject(:lazy_sort_by) do
        [two, one].lazy_sort_by do
          [
            ->(x) { x.length },
            ->(x) { x.cars },
            ->(x) { x.size } 
          ]
        end
      end
        
      let(:one) { double :one, length: 1, cars: 2, size: 2 }
      let(:two) { double :two, length: 1, cars: 2, size: 3 }
    
      it { is_expected.to eq [one, two] }
    end

    context 'when sorting 3 items with similar first of 3 terms' do
      subject(:lazy_sort_by) do
        [three, two, one].lazy_sort_by do
          [
            ->(x) { x.length },
            ->(x) { x.cars },
            ->(x) { x.size } 
          ]
        end
      end
        
      let(:one) { double :one, length: 1, cars: 2, size: 2 }
      let(:two) { double :two, length: 1, cars: 2, size: 3 }
      let(:three) { double :three, length: 1, cars: 2, size: 4 }
    
      it { is_expected.to eq [one, two, three] }
    end
  end
end
