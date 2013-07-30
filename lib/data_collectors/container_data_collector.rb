class ContainerDataCollector
  attr_reader :graph_height, :graph_width, :container_x_padding, :y_label_width, :y_label_offset, :container_y_padding, :x_label_height
  def initialize(graph_height, graph_width, container_x_padding, y_label_width, y_label_offset, container_y_padding, x_label_height)
    @graph_height = graph_height
    @graph_width = graph_width
    @container_x_padding = container_x_padding
    @y_label_width = y_label_width
    @y_label_offset = y_label_offset
    @container_y_padding = container_y_padding
    @x_label_height = x_label_height
  end

  def height
    container_y_padding * 2 + x_label_height + graph_height
  end

  def width
    container_x_padding * 2 + y_label_width + y_label_offset + graph_width
  end

  def graph_top_left_corner
    x = container_x_padding + y_label_width + y_label_offset
    y = container_y_padding + x_label_height + graph_height
    [x, y]
  end
end
