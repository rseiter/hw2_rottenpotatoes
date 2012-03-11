module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  def hilite?(type)
    if @order.to_s == type.to_s then
      return :hilite 
    else
      return nil
    end
  end
  def checked?(rating)
    if @ratings then
      @ratings.include? rating
    end
  end
end
