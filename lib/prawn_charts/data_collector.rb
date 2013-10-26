module PrawnCharts
  class DataCollector
    # Arranges graph data in an easy format for Prawn to process
    attr_reader :height, :width, :data, :y_labels_units, :scale
    def initialize(input)
      @height = input.fetch(:height)
      @width = input.fetch(:width)
      @data = input.fetch(:data)
      @y_labels_units = input.fetch(:y_labels)
      @scale = input.fetch(:scale, :linear)
    end

    def y_labels
      y_labels_units.inject([]) do |memo, label|
        memo << { label: label.to_s, y: y_convert_to_pdf(label) }
        memo
      end
    end

    def horizontal_lines
      y_labels_units.map do |y|
        y_pdf = y_convert_to_pdf(y)
        [[0, y_pdf], [width, y_pdf]]
      end
    end

    def data_points
      @data_points ||= data.map.with_index do |data, index|
        DataPoint.new(
          x_units: index,
          y_units: data[:y],
          x_pdf: index * pdf_points_per_x_unit,
          y_pdf: (y_convert_to_pdf(data[:y]) if data[:y]),
          x_label: data[:x_label]
        )
      end
    end

    def graph_points
      data_points.select { |data_point| data_point.y_pdf }
    end

    def y_convert_to_pdf(n)
      vertical_data_collector.convert_to_pdf(to_float(n))
    end

    private

    def to_float(object)
      return object.gsub(",", "").to_f if object.instance_of? String
      object.to_f
    end

    def vertical_data_collector
      return LinearVerticalDataCollector.new(height, y_labels_units) if scale == :linear
      LogVerticalDataCollector.new(height, y_labels_units)
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
