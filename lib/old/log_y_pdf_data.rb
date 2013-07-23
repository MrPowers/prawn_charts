module PrawnCharts
  class LogYPdfData
    # y_scale is what will be on the y_axis (i.e. [0, 10, 100, 1_000, 10_000, 100_000, ...])
    attr_reader :graph_height, :y_scale
    def initialize(input_data, y_scale, graph_height)
      @input_data = input_data
      @y_scale = y_scale
      @graph_height = graph_height
    end

    def y_position_units(y_input)
      raise "Invalid input" unless y_input.between?(y_scale.min, y_scale.max)
      result = 0
      y_scale.each_with_index do |scale, index|
        upper_scale = y_scale[index + 1]
        if y_input.between?(scale, upper_scale)
          result += (y_scale - scale) / (upper_scale - scale)
        else
          result += 1
        end
      end
      result
    end

    def pdf_points_between_scales
      graph_height / (y_scale.length - 1)
    end

    def y_position_pdf_points(y_input)
      y_position_units * pdf_points_between_scales
    end
  end
end
