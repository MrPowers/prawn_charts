class ContainerDataCollector
  # gap is area between container corner and graph
  def self.left_gap(container_x_padding, y_label_width, y_label_offset)
    container_x_padding + y_label_width + y_label_offset
  end

  def self.right_gap(container_x_padding)
    container_x_padding
  end

  def self.top_gap(container_y_padding, graph_title_height)
    container_y_padding + graph_title_height
  end

  def self.bottom_gap(container_y_padding, x_label_height)
    container_y_padding + x_label_height
  end

  def self.height(bottom_gap, graph_height, top_gap)
    bottom_gap + graph_height + top_gap
  end

  def self.width(left_gap, right_gap, graph_width)
    left_gap + right_gap + graph_width
  end

  def self.graph_top_left(left_gap, container_height, top_gap)
    [left_gap, (container_height - top_gap)]
  end

  def self.graph_title_top_left(left_gap, bottom_gap, graph_height, graph_title_height)
    [left_gap, (bottom_gap + graph_height + graph_title_height)]
  end
end
