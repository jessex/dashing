require 'dashboard'

class Dash
  include Dashboard

  def initialize(name, params)
    @name = name
    @origin = validate_integer "origin", params["origin"]
    @width = validate_integer "width", params["width"]
    @height = validate_integer "height", params["height"]
    @data = params["data"]
  end

  attr_reader :name, :origin, :width, :height, :data
end
