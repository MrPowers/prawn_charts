module PrawnCharts
  class LinearVerticalDataCollector
    attr_reader :height, :y_labels_units
    def initialize(height, y_labels_units)
      @height = height
      @y_labels_units = y_labels_units
    end

    def total_y_units
      y_labels_units.max - y_labels_units.min
    end

    def convert_to_pdf(n)
      height.to_f / total_y_units * n
    end
  end
end
