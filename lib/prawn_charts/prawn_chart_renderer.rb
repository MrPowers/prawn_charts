module PrawnCharts
  module PrawnChartRenderer
    def draw_line(graph_points)
      data = graph_points.reject { |x, y| y.nil? }
      data.each_index do |i|
        stroke_line(data[i], data[i + 1]) unless data[i + 1].nil?
      end
    end

    def draw_dots(graph_points, dot_radius)
      data = graph_points.reject { |x, y| y.nil? }
      data.each do |point|
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

    def draw_graph(input, colors = {})
      assistant = RendererAssistant.new(input)
      black = "000000"
      collector = assistant.collector
      stroke_axis
      translate(*input[:graph][:starting_point]) do
        self.stroke_color = colors[:rectangle_border] if colors[:rectangle_border]
        stroke_rectangle([0, collector.height], collector.width, collector.height)
        self.stroke_color = black

        self.fill_color = colors[:rectangle_fill] if colors[:rectangle_fill]
        fill_rectangle([0, collector.height], collector.width, collector.height) if colors[:rectangle_fill]
        self.fill_color = black

        self.stroke_color = colors[:line] if colors[:line]
        draw_line(collector.graph_data_points)
        self.stroke_color = black

        self.fill_color = colors[:dots] if colors[:dots]
        draw_dots(collector.graph_data_points, assistant.dot_radius) if input[:dots]
        self.fill_color = black

        self.fill_color = colors[:x_labels] if colors[:x_labels]
        draw_x_labels(collector.x_labels, assistant.x_labels_offset, assistant.x_labels_options) if input[:x_labels]
        self.fill_color = black

        self.fill_color = colors[:y_labels] if colors[:y_labels]
        draw_y_labels(collector.y_labels, assistant.y_labels_offset, assistant.y_labels_options) if input[:y_labels]
        self.fill_color = black

        self.stroke_color = colors[:horizontal_lines] if colors[:horizontal_lines]
        draw_horizontal_lines(collector.horizontal_lines) if input[:horizontal_lines]
        self.stroke_color = black

        self.fill_color = colors[:graph_title] if colors [:graph_title]
        draw_title(assistant.graph_title_translate, assistant.graph_title, assistant.graph_title_options) if input[:graph_title]
        self.fill_color = black

        self.fill_color = colors[:x_title] if colors [:x_title]
        draw_title(assistant.x_title_translate, assistant.x_title, assistant.x_title_options) if input[:x_title]
        self.fill_color = black

        self.fill_color = colors[:y_title] if colors[:y_title]
        draw_title(assistant.y_title_translate, assistant.y_title, assistant.y_title_options) if input[:y_title]
        self.fill_color = black
      end
    end
  end
end
