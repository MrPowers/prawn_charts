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

    def draw_graph(point, width, height, data, dot_radius = 4)
      graph_points = SingleFileDataCollector.new(height, width, data).graph_data_points
      translate(*point) do
        stroke_rectangle([0, height], width, height)
        draw_line(graph_points)
        draw_dots(graph_points, dot_radius)
      end
    end
  end
end
