module PrawnCharts
  class DataPoint
    attr_reader :x_units, :y_units, :x_pdf, :y_pdf, :x_label
    def initialize(input)
      @x_units = input.fetch :x_units
      @y_units = input.fetch :y_units
      @x_pdf = input.fetch :x_pdf
      @y_pdf = input.fetch :y_pdf
      @x_label = input.fetch :x_label
    end

    def coordinate
      [x_pdf, y_pdf]
    end
  end
end
