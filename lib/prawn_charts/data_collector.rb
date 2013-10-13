module PrawnCharts
  DataPoint = Struct.new(:x_label, :y_value)

  class DataCollector
    # Arranges graph data in an easy format for Prawn to process
    attr_reader :height, :width, :data
    def initialize(input)
      @height = input.fetch(:height)
      @width = input.fetch(:width)
      @data = input.fetch(:data)
      @y_labels_units = input.fetch(:y_labels, nil)
    end

    # Array of pdf x, y coordinates corresponding to points on a graph
    def graph_data_points
      x_pdf_data_points.zip(y_pdf_data_points).reject { |x, y| y.nil? }
    end

    # 
    def x_labels
      result = []
      data_points.each_with_index do |data_point, index|
        result << { label: data_point.x_label, x: x_pdf_data_points[index] }
      end
      result
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

    private

    def data_points
      @data_points ||= data.map { |data| DataPoint.new(data[:x_label], data[:y]) }
    end

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

    def y_pdf_data_points
      data_points.map  do |data_point|
        data_point.y_value ? data_point.y_value * pdf_points_per_y_unit : nil
      end
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
