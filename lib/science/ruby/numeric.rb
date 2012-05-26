# Extensions to Ruby builtin Numeric class.
class Numeric

  # Determines if the number is positive or not.
  # @return [Boolean] `true` if the number is positive (or 0), `false` orthewise.
  def positive?
    self >= 0
  end
  alias pos? positive? 
  
  # Determines if the number is negative or not.
  # @return [Boolean] `true` if the number is negative (or 0), `false` orthewise.
  def negative?
    self <= 0
  end
  alias neg? negative?
end
