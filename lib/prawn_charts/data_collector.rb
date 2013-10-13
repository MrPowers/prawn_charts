module PrawnCharts
  class DataCollector
    # Arranges graph data in an easy format for Prawn to process
    attr_reader :height, :width, :data
    def initialize(input)
      @height = input.fetch(:height)
      @width = input.fetch(:width)
      @data = input.fetch(:data)
      @y_labels_units = input.fetch(:y_labels, nil)
    end

    def y_labels
      y_labels_units.inject([]) do |memo, label|
        memo << { label: label.to_s, y: label * pdf_points_per_y_unit}
        memo
      end
    end

    def horizontal_lines
      y_labels_pdf.map do |y|
        [[0, y], [width, y]]
      end
    end

    def data_points
      @data_points ||= data.map.with_index do |data, index|
        DataPoint.new(
          x_units: index,
          y_units: data[:y],
          x_pdf: index * pdf_points_per_x_unit,
          y_pdf: (data[:y] * pdf_points_per_y_unit if data[:y]),
          x_label: data[:x_label]
        )
      end
    end

    def graph_points
      data_points.select { |data_point| data_point.x_pdf && data_point.y_pdf }
    end

    private

    # y methods
    def y_labels_units
      @y_labels_units || default_y_labels_units
    end

    def default_y_labels_units
      [0, (max_y_units.to_f / 2), max_y_units]
    end

    def y_labels_pdf
      y_labels_units.map do |label|
        (label * pdf_points_per_y_unit).round(1)
      end
    end

    def max_y_units
      @y_labels_units ? @y_labels_units.max : data_points.map {|data_point| data_point.y_value}.max_units_units
    end

    def pdf_points_per_y_unit
      height / max_y_units.to_f
    end

    # x methods
    def max_x_units
      data.length - 1
    end

    def pdf_points_per_x_unit
      width / max_x_units.to_f
    end
  end
end
