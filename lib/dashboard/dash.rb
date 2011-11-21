class Dash
  def initialize(name, params)
    @name = name
    @origin = params["origin"]
    @width = params["width"]
    @height = params["height"]
    @color = params["color"]
    @data = params["data"]
  end

  attr_reader :name, :origin, :width, :height, :color, :data
end
