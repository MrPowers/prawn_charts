module PrawnCharts
  class LogVerticalDataCollector
    attr_reader :height, :y_labels_units
    def initialize(height, y_labels_units)
      @height = height
      @y_labels_units = y_labels_units
    end

    def convert_to_pdf(n)
      Math.log10(n) * pdf_points_per_increment
    end

    private

    def number_of_labels
      y_labels_units.length
    end

    def number_of_increments
      number_of_labels - 1
    end

    def pdf_points_per_increment
      height.to_f / number_of_increments
    end
  end
end
