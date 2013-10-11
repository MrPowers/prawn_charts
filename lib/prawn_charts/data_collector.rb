module PrawnCharts
  class DataCollector
    attr_reader :height, :width, :data
    # data is in this format = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}]
    # {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]}
    def initialize(input)
      @height = input.fetch(:height)
      @width = input.fetch(:width)
      @data = input.fetch(:data)
      @y_labels_units = input.fetch(:y_labels, nil)
    end

    def graph_data_points
      x_pdf_data_points.zip(y_pdf_data_points)
    end

    def x_labels
      result = []
      data.each_with_index do |data_point, index|
        result << { label: data_point[:x_label], x: x_pdf_data_points[index] }
      end
      result
    end

    def y_labels
      result = []
      y_labels_pdf.each do |label|
        result << { label: label.to_s, y: label}
      end
      result
    end

    def horizontal_lines
      y_labels_pdf.map do |y|
        [[0, y], [width, y]]
      end
    end

    private

    # y methods
    def y_labels_units
      [0, (max_y_units.to_f / 2), max_y_units]
    end

    def y_labels_pdf
      labels = @y_labels_units || y_labels_units
      labels.map do |label|
        (label * pdf_points_per_y_unit).round(1)
      end
    end

    def max_y_units
      @y_labels_units ? @y_labels_units.max : data.map {|h| h[:y]}.max_units_units
    end

    def pdf_points_per_y_unit
      height / max_y_units.to_f
    end

    def y_pdf_data_points
      data.map {|h| h[:y] * pdf_points_per_y_unit}
    end

    # x methods
    def max_x_units
      data.length - 1
    end

    def pdf_points_per_x_unit
      width / max_x_units.to_f
    end

    def x_pdf_data_points
      result = [0]
      (data.length - 1).times do
        result << (result[-1] + pdf_points_per_x_unit)
      end
      result
    end

  end
end
