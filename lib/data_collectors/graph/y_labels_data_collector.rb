module PrawnCharts
  class YLabelsDataCollector
    attr_reader :y_labels, :graph_height_pdf, :label_width, :label_height, :y_label_offset
    def initialize(y_labels, graph_height_pdf, label_width, label_height, y_label_offset)
      @y_labels = y_labels
      @graph_height_pdf = graph_height_pdf
      @label_width = label_width
      @label_height = label_height
      @y_label_offset = y_label_offset
    end

    def collect
      y_labels.map.with_index do |y_label, index|
        y_label = number_to_string_with_commas(y_label)
        x_pdf = -label_width - y_label_offset
        y_pdf = index * y_label_increment + vertical_offset
        [y_label, [x_pdf, y_pdf]]
      end
    end

    private

    def vertical_offset
      label_height / 2
    end

    def y_label_increment
      graph_height_pdf.to_f / (y_labels.count - 1)
    end

    def number_to_string_with_commas(number)
      number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end
  end
end
