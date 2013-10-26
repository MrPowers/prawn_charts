module PrawnCharts
  class LinearVerticalDataCollector
    attr_reader :height, :y_labels_units
    def initialize(height, y_labels_units)
      @height = height
      @y_labels_units = y_labels_units
    end

    def convert_to_pdf(n)
      pdf_points_per_y_unit * n
    end

    private

    def pdf_points_per_y_unit
      height.to_f / total_y_units
    end

    def total_y_units
      y_labels_units.max - y_labels_units.min
    end
  end
end
