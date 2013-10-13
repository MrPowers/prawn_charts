module PrawnCharts
  module PrawnChartRenderer
    def draw_line(graph_points)
      graph_points.each_index do |i|
        stroke_line(graph_points[i], graph_points[i + 1]) unless graph_points[i + 1].nil?
      end
    end

    def draw_dots(graph_points, dot_radius)
      graph_points.each do |point|
        fill_circle(point, dot_radius)
      end
    end

    def draw_x_labels(label_data, offset, options)
      label_width = options[:width]
      centering_adjustment = label_width / 2
      translate(0, offset) do
        label_data.each do |data|
         text_box(data[:label], {at: [(data[:x] - centering_adjustment), 0]}.merge(options))
        end
      end
    end

    def draw_y_labels(label_data, offset, options)
      label_height = options[:height]
      centering_adjustment = label_height / 2
      translate(offset, 0) do
        label_data.each do |data|
          text_box(data[:label], {at: ([0, data[:y] + centering_adjustment]) }.merge(options))
        end
      end
    end

    def draw_horizontal_lines(data)
      data.each do |start_point, end_point|
        stroke_line(start_point, end_point)
      end
    end

    def draw_title(translation, title, options)
      translate(*translation) do
        text_box(title, options)
      end
    end

    def set_component_color(method, colors, component)
      self.send(method, colors[component]) if colors[component]
    end

    def stroke_black
      black = "000000"
      self.stroke_color = black
    end

    def fill_black
      black = "000000"
      self.fill_color = black
    end

    # not using this yet, but want a cool way to refactor draw_graph using the specified components to make 
    # the code nicer
    def components_to_draw(input)
      available_components = [:line, :dots, :x_labels, :y_labels, :horizontal_lines, :graph_title, :y_title, :x_title]
      specified_components = [:line] + input.keys
      available_components & specified_components
    end

    def draw_graph(input, colors = {})
      assistant = RendererAssistant.new(input)
      collector = assistant.collector
      stroke_axis
      translate(*input[:graph][:starting_point]) do
        set_component_color(:stroke_color, colors, :rectangle_border)
        stroke_rectangle([0, collector.height], collector.width, collector.height)
        stroke_black

        set_component_color(:fill_color, colors, :rectangle_fill)
        fill_rectangle([0, collector.height], collector.width, collector.height) if colors[:rectangle_fill]
        fill_black

        set_component_color(:stroke_color, colors, :line)
        draw_line(collector.graph_data_points)
        stroke_black

        set_component_color(:fill_color, colors, :dots)
        draw_dots(collector.graph_data_points, assistant.dot_radius) if input[:dots]
        stroke_black

        set_component_color(:fill_color, colors, :x_labels)
        draw_x_labels(collector.x_labels, assistant.x_labels_offset, assistant.x_labels_options) if input[:x_labels]
        stroke_black

        set_component_color(:fill_color, colors, :y_labels)
        draw_y_labels(collector.y_labels, assistant.y_labels_offset, assistant.y_labels_options) if input[:y_labels]
        stroke_black

        set_component_color(:stroke_color, colors, :horizontal_lines)
        draw_horizontal_lines(collector.horizontal_lines) if input[:horizontal_lines]
        stroke_black

        set_component_color(:fill_color, colors, :graph_title)
        draw_title(assistant.graph_title_translate, assistant.graph_title, assistant.graph_title_options) if input[:graph_title]
        stroke_black

        set_component_color(:fill_color, colors, :x_title)
        draw_title(assistant.x_title_translate, assistant.x_title, assistant.x_title_options) if input[:x_title]
        stroke_black

        set_component_color(:fill_color, colors, :y_title)
        draw_title(assistant.y_title_translate, assistant.y_title, assistant.y_title_options) if input[:y_title]
        stroke_black
      end
    end
  end
end
