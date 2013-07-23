module PrawnCharts
  class XPdfData
    attr_reader :input_data, :graph_width
    def initialize(input_data, graph_width)
      @input_data = input_data
      @graph_width = graph_width
    end

    def x_increment
      graph_width.to_f / (input_data.length - 1)
    end

    def x_label_data(offset)
      x_position = 0
      result = []
      input_data.each do |x, y|
        result << [x, [x_position, offset]]
        x_position += x_increment
      end
      result
    end
  end
end
