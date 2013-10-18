module PrawnCharts
  class RendererAssistant
    # Parses input data and responds with smart defaults or user specified data
    attr_reader :input
    def initialize(input)
      @input = input
    end

    def collector
      @collector ||= DataCollector.new(input.fetch(:graph))
    end

    def components_to_draw
      available_components = [:rectangle_border, :rectangle_fill, :line, :dots, :x_labels, :y_labels, :horizontal_lines, :graph_title, :y_title, :x_title]
      specified_components = [:rectangle_border, :rectangle_fill, :line] + @input.keys
      @components_to_draw = available_components & specified_components
    end

    # dots
    def dot_radius
      return default_dot_radius unless input.dig(:dots, :radius)
      input[:dots][:radius]
    end

    # graph_title
    def graph_title_translate
      [0, collector.height + offset(:graph_title, default_graph_title_offset)]
    end

    def graph_title
      raise "Graph must have title" unless input.dig(:graph_title, :title)
      input[:graph_title][:title]
    end

    def graph_title_options
      return default_graph_title_options unless input.dig(:graph_title, :text_box_options)
      input[:graph_title][:text_box_options]
    end

    # x_title
    def x_title_translate
      [0, offset(:x_title, default_x_title_offset)]
    end

    def x_title
      raise "Graph must have title" unless input.dig(:x_title, :title)
      input[:x_title][:title]
    end

    def x_title_options
      return default_x_title_options unless input.dig(:x_title, :text_box_options)
      input[:x_title][:text_box_options]
    end

    # y_title
    def y_title_translate
      [offset(:y_title, default_y_title_offset), 0]
    end

    def y_title
      raise "Graph must have title" unless input.dig(:y_title, :title)
      input[:y_title][:title]
    end

    def y_title_options
      return default_y_title_options unless input.dig(:y_title, :text_box_options)
      input[:y_title][:text_box_options]
    end

    # x_labels
    def x_labels_offset
      offset(:x_labels, default_x_labels_offset)
    end

    def x_labels_options
      return default_x_labels_options unless input.dig(:x_labels, :text_box_options)
      input[:x_labels][:text_box_options]
    end

    # y_labels
    def y_labels_offset
      offset(:y_labels, default_y_labels_offset)
    end

    def y_labels_options
      return default_y_labels_options unless input.dig(:y_labels, :text_box_options)
      default_y_labels_options.merge(input[:y_labels][:text_box_options])
    end

    private

    def default_dot_radius
      4
    end

    def offset(title_type, default_offset)
      return default_offset unless input.dig(title_type, :offset)
      input[title_type][:offset]
    end

    # graph title
    def default_graph_title_options
      {at: [0, -20], width: collector.width, height: 20, align: :center}
    end

    def default_graph_title_offset
      50
    end

    # x title
    def default_x_title_options
      {at: [0, 20], width: collector.width, height: 20, align: :center}
    end

    def default_x_title_offset
      -60
    end

    # y title
    def default_y_title_options
      {at: [0, 0], width: collector.height, height: 20, align: :center, valign: :center, rotate: 90}
    end

    def default_y_title_offset
      -50
    end

    # x_labels
    def default_x_labels_offset
      -50
    end

    def default_x_labels_options
      { :width => 100, :height => 20, align: :center, rotate: 45 }
    end

    # y_labels
    def default_y_labels_offset
      -40
    end

    def default_y_labels_options
      { width: 40, :height => 40, valign: :center }
    end
  end
end
