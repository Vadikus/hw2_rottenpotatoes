module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def hi(column)
    if column == params[:sort] 
      "hilite"
    end
  end
end
