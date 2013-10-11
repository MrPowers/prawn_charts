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

    def draw_graph(input)
      collector = SingleFileDataCollector.new(input.fetch(:graph))
      assistant = RendererAssistant.new(input)
      translate(*input[:graph][:starting_point]) do
        stroke_rectangle([0, collector.height], collector.width, collector.height)
        draw_line(collector.graph_data_points)
        draw_dots(collector.graph_data_points, assistant.dot_radius) if input[:dots]
        draw_x_labels(collector.x_labels, assistant.x_labels_offset, assistant.x_labels_options) if input[:x_labels]
        draw_y_labels(collector.y_labels, assistant.y_labels_offset, assistant.y_labels_options) if input[:y_labels]
        draw_horizontal_lines(collector.horizontal_lines) if input[:horizontal_lines]
        draw_title(assistant.graph_title_translate, assistant.graph_title, assistant.graph_title_options) if input[:graph_title]
        draw_title(assistant.x_title_translate, assistant.x_title, assistant.x_title_options) if input[:x_title]
        draw_title(assistant.y_title_translate, assistant.y_title, assistant.y_title_options) if input[:y_title]
      end
    end
  end
end
