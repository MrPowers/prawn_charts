module PrawnCharts
  module PrawnChartRenderer
    def draw_line(graph_points)
      graph_points.each_index do |i|
        stroke_line(graph_points[i], graph_points[i + 1]) unless graph_points[i + 1].nil?
      end
    end

    def draw_dots(graph_points, dot_radius = 4)
      graph_points.each do |point|
        fill_circle(point, dot_radius)
      end
    end

    def draw_x_labels(label_data)
      text_box_width = 100
      horizontal_offset = text_box_width / 2
      translate(0, -70) do
        label_data.each do |data|
         text_box(data[:label], {at: [(data[:x] - horizontal_offset), 20], width: text_box_width, align: :center, rotate: 45})
        end
      end
    end

    def draw_y_labels(label_data)
      text_box_height = 40
      vertical_offset = text_box_height / 2
      translate(-40, 0) do
        label_data.each do |data|
          text_box(data[:label], {at: [5, data[:y] + vertical_offset], height: text_box_height, width: 40, valign: :center})
        end
      end
    end

    def draw_horizontal_lines(data)
      data.each do |start_point, end_point|
        stroke_line(start_point, end_point)
      end
    end

    def draw_title(title, graph_height, graph_width, vertical_offset, text_box_options)
      default_options = {at: [0, -20], width: graph_width, height: 20, align: :center}
      translate(0, graph_height + vertical_offset) do
        text_box(title, default_options.merge(text_box_options))
      end
    end

    def draw_x_title(title, graph_width, vertical_offset, text_box_options)
      default_options = {at: [0, 20], width: graph_width, height: 20, align: :center}
      translate(0, vertical_offset) do
        text_box(title, default_options.merge(text_box_options))
      end
    end

    def draw_y_title(title, graph_height, horizontal_offset, text_box_options)
      default_options = {at: [0, 0], width: graph_height, height: 20, align: :center, valign: :center, rotate: 90}
      translate(horizontal_offset, 0) do
        text_box(title, default_options.merge(text_box_options))
      end
    end

    def draw_graph(starting_point, width, height, data, y_labels_units = nil)
      collector = SingleFileDataCollector.new(height, width, data, y_labels_units)
      translate(*starting_point) do
        stroke_rectangle([0, height], width, height)
        draw_line(collector.graph_data_points)
        draw_dots(collector.graph_data_points)
        draw_x_labels(collector.x_labels)
        draw_y_labels(collector.y_labels)
        draw_horizontal_lines(collector.horizontal_lines)
        draw_title("Cool graph", collector.height, collector.width, 50, {})
        draw_x_title("X Title", collector.width, -60, {})
        draw_y_title("Y Title", collector.height, -50, {})
      end
    end
    data = [{y: 5, x_label: "Jan 11"}, {y: 17, x_label: "Feb 11"}, {y: 14, x_label: "Mar 11"}]
    input = {
      :graph => {:starting_point => [100, 200], :width => 300, :height => 200, :data => data, :y_labels => [0, 5, 10, 15, 20]},
      :horizontal_lines => true,
      :graph_title => { :title => "cool graph", :vertical_offset => 50, :text_box_options => {}},
      :x_title => { :title => "x title", :vertical_offset => -60, :text_box_options => {}},
      :y_title => { :title => "y title", :horizontal_offset => -50, :text_box_options => {}}
    }
  end
end
