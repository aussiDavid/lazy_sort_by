module Enumerable
  def lazy_sort_by &block
    if size == 1
      return self
    end
    
    if size == 2
      block.call.each do |compariator|
        if compariator.(first) > compariator.(last)
          return [last, first]
        end
        
        if compariator.(first) < compariator.(last)
          return [first, last]
        end
      end
      
      return [first, last]
    end

    if size == 3
      return block.call.reduce(first(2)) do |compariator, acc|
        compariator.(acc[0]) > compariator.(acc[1]) ? [acc[1], acc[0]] : [acc[0], acc[1]]
      end
    end
  end
end
