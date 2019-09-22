module Enumerable
  def lazy_sort_by(&block)
    if block
      sort_by(&block)
    else
      sort
    end
  end
end
