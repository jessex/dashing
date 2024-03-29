module Dashboard

  class LayoutError < ArgumentError
  end

  def Dashboard.validate_integer(name, value)
    raise(ArgumentError, "Value for dashboard parameter #{name} was nil", caller) if value.nil?
    raise(ArgumentError, "Value for dashboard parameter #{name} was not an integer", caller) if !value.is_a? Integer
    value
  end

  def Dashboard.validate_layout(board)
    layout = Hash.new('')

    for param in ['rows', 'columns', 'width', 'height'] do
      if eval("board.#{param}") < 1
        raise LayoutError, "Value '#{param}' for board invalid: less than 1", caller
      end
    end

    board.dashes.each do |dash|

      for param in ['row', 'column', 'width', 'height'] do
        threshold = 1
        if param.eql? 'row' or param.eql? 'column'
          threshold = 0
        end

        if eval("dash.#{param}") < threshold
          raise LayoutError, "Value '#{param}' for dash #{dash.name} invalid: less than #{threshold}", caller
        end
      end

      if dash.row + dash.height > board.rows
        raise LayoutError, "Dash #{dash.name} has too great of a height", caller
      end
      if dash.column + dash.width > board.columns
        raise LayoutError, "Dash #{dash.name} has too great of a width", caller
      end

      dash.row.upto(dash.row + dash.height - 1) do |i|
        dash.column.upto(dash.column + dash.width - 1) do |j|
          if !''.eql? layout[[i,j]]
            raise LayoutError,
                  "Dash #{dash.name} overlaps with dash #{layout[[i,j]]} at row #{i} and column #{j}", caller
          else
            layout[[i, j]] = dash.name
          end
        end
      end

    end
  end

  class Board
    def initialize(params)
      @rows = Dashboard.validate_integer 'rows', params['rows']
      @columns = Dashboard.validate_integer 'columns', params['columns']
      @width = Dashboard.validate_integer 'width', params['width']
      @height = Dashboard.validate_integer 'height', params['height']
      @margin = Dashboard.validate_integer 'margin', params['margin']
      @color = params['color']

      params['title'] ||= 'Dashboard'
      @title = params['title']

      if @rows < 1 or @columns < 1 or @height < 1 or @width < 1
        raise ArgumentError, "None of row count, column count, height or width for board can be less than 1", caller
      end

      raise(ArgumentError, 'Configured board contained no dashes', caller) if params['dashes'].nil?
      @dashes = params['dashes'].keys.map do |dash|
        Dash.new dash, params['dashes'][dash]
      end

      @row_height = (@height - ((@rows - 1) * @margin)) / @rows
      @column_width = (@width - ((@columns - 1) * @margin)) / @columns
    end

    attr_accessor :rows, :columns, :width, :height, :margin, :color, :title, :dashes, :row_height, :column_width
  end

  class Dash
    def initialize(name, params)
      @name = name
      @type = params['type']
      @row = Dashboard.validate_integer 'row', params['row']
      @column = Dashboard.validate_integer 'column', params['column']
      @width = Dashboard.validate_integer 'width', params['width']
      @height = Dashboard.validate_integer 'height', params['height']
      @refresh_rate = params['refresh_rate']
      @data = params['data']
      @color = params['color']
    end

    attr_accessor :name, :type, :row, :column, :width, :height, :refresh_rate, :data, :color
  end
end
