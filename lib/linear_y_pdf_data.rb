module PrawnCharts
  class LinearYPdfData
    attr_reader :input_data, :graph_height
    def initialize(input_data, graph_height)
      @input_data = input_data
      @graph_height = graph_height
    end

    def max_y
      input_data.map {|x, y| y}.compact.max
    end

    def y_increment
      graph_height.to_f / max_y
    end

    def y_label_data(num_labels, offset)
      y_label_increment = graph_height.to_f / (num_labels)
      y_label_value_increment = max_y.to_f / (num_labels)
      result = []
      (num_labels + 1).times do |counter|
        result << [y_label_value_increment * counter, [offset, y_label_increment * counter]]
      end
      result
    end
  end
end
