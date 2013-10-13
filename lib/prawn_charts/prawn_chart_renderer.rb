module PrawnCharts
  module PrawnChartRenderer
    def draw_line(graph_points)
      graph_points.each_index do |i|
        stroke_line(graph_points[i].coordinate, graph_points[i + 1].coordinate) unless graph_points[i + 1].nil?
      end
    end

    def draw_dots(graph_points, dot_radius)
      graph_points.each do |point|
        fill_circle(point.coordinate, dot_radius)
      end
    end

    def draw_x_labels(data_points, offset, options)
      label_width = options[:width]
      centering_adjustment = label_width / 2
      translate(0, offset) do
        data_points.each do |data_point|
         text_box(data_point.x_label, {at: [(data_point.x_pdf - centering_adjustment), 0]}.merge(options))
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

    def set_color_and_execute(method, component, &block)
      self.send(method, @colors[component]) if @colors[component]
      yield if components_to_draw.include?(component)
      set_color_black(method)
    end

    def set_color_black(method)
      black = "000000"
      self.send(method, black)
    end

    def components_to_draw
      available_components = [:rectangle_border, :rectangle_fill, :line, :dots, :x_labels, :y_labels, :horizontal_lines, :graph_title, :y_title, :x_title]
      specified_components = [:rectangle_border, :rectangle_fill, :line] + @input.keys
      @components_to_draw = available_components & specified_components
    end

    def draw_graph(input, colors = {})
      assistant = RendererAssistant.new(input)
      collector = assistant.collector
      @input = input
      @colors = colors
      stroke_axis
      translate(*input[:graph][:starting_point]) do
        set_color_and_execute(:stroke_color, :rectangle_border) do
          stroke_rectangle([0, collector.height], collector.width, collector.height)
        end

        set_color_and_execute(:fill_color, :rectangle_fill) do
          fill_rectangle([0, collector.height], collector.width, collector.height)
        end

        set_color_and_execute(:stroke_color, :line) do
          draw_line(collector.graph_points)
        end

        set_color_and_execute(:fill_color, :dots) do
          draw_dots(collector.graph_points, assistant.dot_radius)
        end

        set_color_and_execute(:fill_color, :x_labels) do
          draw_x_labels(collector.data_points, assistant.x_labels_offset, assistant.x_labels_options)
        end

        set_color_and_execute(:fill_color, :y_labels) do
          draw_y_labels(collector.y_labels, assistant.y_labels_offset, assistant.y_labels_options)
        end

        set_color_and_execute(:stroke_color, :horizontal_lines) do
          draw_horizontal_lines(collector.horizontal_lines)
        end

        set_color_and_execute(:fill_color, :graph_title) do
          draw_title(assistant.graph_title_translate, assistant.graph_title, assistant.graph_title_options)
        end

        set_color_and_execute(:fill_color, :x_title) do
          draw_title(assistant.x_title_translate, assistant.x_title, assistant.x_title_options)
        end

        set_color_and_execute(:fill_color, :y_title) do
          draw_title(assistant.y_title_translate, assistant.y_title, assistant.y_title_options)
        end
      end
    end
  end
end
