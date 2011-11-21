require 'dashboard'

class Board
  include Dashboard

  def initialize(params)
    @rows = validate_integer "rows", params["rows"]
    @columns = validate_integer "columns", params["columns"]
    @width = validate_integer "width", params["width"]
    @height = validate_integer "height", params["height"]
    @margin = validate_integer "margin", params["margin"]
    @color = params["color"]

    @dashes = params["dashes"].keys.map do |dash|
      Dash.new dash, config["dashes"][dash]
    end
  end

  attr_reader :rows, :columns, :width, :height, :margin, :color, :dashes
end
