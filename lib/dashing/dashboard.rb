module Dashboard
  def Dashboard.create_board(params)
    Board.new params
  end

  def Dashboard.validate_integer(name, value)
    raise(ArgumentError, "Value for dashboard parameter #{name} was nil", caller) if value.nil?
    raise(ArgumentError, "Value for dashboard parameter #{name} was not an integer", caller) if !value.is_a? Integer
    value
  end

end
