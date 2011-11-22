module Dashboard
  def Dashboard.validate_integer(name, value)
    raise(ArgumentError, "Value for dashboard parameter #{name} was nil", caller) if value.nil?
    raise(ArgumentError, "Value for dashboard parameter #{name} was not an integer", caller) if !value.is_a? Integer
    value
  end

  class Board
    def initialize(params)
      @rows = Dashboard.validate_integer "rows", params["rows"]
      @columns = Dashboard.validate_integer "columns", params["columns"]
      @width = Dashboard.validate_integer "width", params["width"]
      @height = Dashboard.validate_integer "height", params["height"]
      @margin = Dashboard.validate_integer "margin", params["margin"]
      @color = params["color"]

      @dashes = params["dashes"].keys.map do |dash|
        Dash.new dash, params["dashes"][dash]
      end
    end

    attr_reader :rows, :columns, :width, :height, :margin, :color, :dashes
  end

  class Dash
    def initialize(name, params)
      @name = name
      @row = Dashboard.validate_integer "row", params["row"]
      @column = Dashboard.validate_integer "column", params["column"]
      @width = Dashboard.validate_integer "width", params["width"]
      @height = Dashboard.validate_integer "height", params["height"]
      @data = params["data"]
    end

    attr_reader :name, :row, :column, :width, :height, :data
  end
end
