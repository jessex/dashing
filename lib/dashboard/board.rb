class Board
  def initialize(params)
    @rows = params["rows"]
    @columns = params["columns"]
    @width = params["width"]
    @height = params["height"]
    @margin = params["margin"]
    @color = params["color"]

    @dashes = params["dashes"].keys.map do |dash|
      Dash.new dash, config["dashes"][dash]
    end
  end

  attr_reader :rows, :columns, :width, :height, :margin, :color, :dashes
end
